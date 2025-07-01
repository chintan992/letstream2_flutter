import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/watchlist_provider.dart';
import 'widgets/watchlist_item_card.dart';

class WatchlistScreen extends ConsumerStatefulWidget {
  const WatchlistScreen({super.key});

  @override
  ConsumerState<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends ConsumerState<WatchlistScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load watchlist on screen initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(watchlistProvider.notifier).loadWatchlist();
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
      ref.read(watchlistProvider.notifier).loadMoreWatchlist();
    }
  }

  void _navigateToDetails(int mediaId, String mediaType) {
    context.push('/details/$mediaId?type=$mediaType');
  }

  @override
  Widget build(BuildContext context) {
    final watchlistState = ref.watch(watchlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Watchlist'),
        actions: [
          if (watchlistState.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: () => _showClearConfirmationDialog(),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(watchlistProvider.notifier).loadWatchlist();
        },
        child: _buildContent(watchlistState),
      ),
    );
  }

  Widget _buildContent(WatchlistState state) {
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
              'Error loading watchlist',
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
                ref.read(watchlistProvider.notifier).loadWatchlist();
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
              Icons.bookmark_border,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Your watchlist is empty',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Add movies and TV shows to keep track of what you want to watch',
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
        return WatchlistItemCard(
          watchlistItem: item,
          onTap: () => _navigateToDetails(item.mediaId, item.mediaType),
          onRemove: () => _showRemoveConfirmationDialog(item),
        );
      },
    );
  }

  void _showRemoveConfirmationDialog(watchlistItem) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Watchlist'),
        content: Text('Remove "${watchlistItem.title}" from your watchlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(watchlistProvider.notifier).removeFromWatchlist(watchlistItem.id);
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
        title: const Text('Clear Watchlist'),
        content: const Text('Are you sure you want to remove all items from your watchlist?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(watchlistProvider.notifier).clearWatchlist();
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
