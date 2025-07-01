import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/favorites_provider.dart';
import 'widgets/favorite_item_card.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load favorites on screen initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(favoritesProvider.notifier).loadFavorites();
    });

    // Setup scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(favoritesProvider.notifier).loadMoreFavorites();
    }
  }

  void _navigateToDetails(int mediaId, String mediaType) {
    context.push('/details/$mediaId?type=$mediaType');
  }

  @override
  Widget build(BuildContext context) {
    final favoritesState = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        actions: [
          if (favoritesState.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => _showClearConfirmationDialog(),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(favoritesProvider.notifier).loadFavorites();
        },
        child: _buildContent(favoritesState),
      ),
    );
  }

  Widget _buildContent(FavoritesState state) {
    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading favorites',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(favoritesProvider.notifier).loadFavorites();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No favorites yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Save your favorite movies and TV shows here.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: state.items.length + (state.isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= state.items.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final item = state.items[index];
        return FavoriteItemCard(
          favoriteItem: item,
          onTap: () => _navigateToDetails(item.mediaId, item.mediaType),
          onRemove: () => _showRemoveConfirmationDialog(item),
        );
      },
    );
  }

  void _showRemoveConfirmationDialog(favoriteItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Favorites'),
        content: Text('Remove "${favoriteItem.title}" from your favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(favoritesProvider.notifier).removeFromFavorites(favoriteItem.id);
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _showClearConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Favorites'),
        content: const Text('Are you sure you want to remove all items from your favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(favoritesProvider.notifier).clearFavorites();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
