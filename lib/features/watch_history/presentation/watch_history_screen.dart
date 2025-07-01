import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../application/watch_history_provider.dart';
import 'widgets/watch_history_item_card.dart';
import '../../../core/widgets/shimmer_loading.dart';

class WatchHistoryScreen extends ConsumerStatefulWidget {
  const WatchHistoryScreen({super.key});

  @override
  ConsumerState<WatchHistoryScreen> createState() => _WatchHistoryScreenState();
}

class _WatchHistoryScreenState extends ConsumerState<WatchHistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _confirmClearHistory = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load watch history when screen initializes
    Future.microtask(() => ref.read(watchHistoryProvider.notifier).loadWatchHistory());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(watchHistoryProvider.notifier).loadMoreWatchHistory();
    }
  }

  void _clearWatchHistory() {
    setState(() {
      _confirmClearHistory = false;
    });
    ref.read(watchHistoryProvider.notifier).clearWatchHistory();
  }

  @override
  Widget build(BuildContext context) {
    final watchHistoryState = ref.watch(watchHistoryProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch History'),
        elevation: 0,
        actions: [
          if (!_confirmClearHistory && watchHistoryState.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Clear History',
              onPressed: () {
                setState(() {
                  _confirmClearHistory = true;
                });
              },
            ),
          if (_confirmClearHistory)
            TextButton(
              onPressed: _clearWatchHistory,
              child: const Text(
                'Confirm Clear',
                style: TextStyle(color: Colors.red),
              ),
            ),
          if (_confirmClearHistory)
            TextButton(
              onPressed: () {
                setState(() {
                  _confirmClearHistory = false;
                });
              },
              child: const Text('Cancel'),
            ),
        ],
      ),
      body: watchHistoryState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${watchHistoryState.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(watchHistoryProvider.notifier).loadWatchHistory();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : _buildHistoryList(watchHistoryState),
    );
  }

  Widget _buildHistoryList(WatchHistoryState state) {
    if (state.isLoading && state.items.isEmpty) {
      return _buildLoadingShimmer();
    }

    if (state.items.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(watchHistoryProvider.notifier).loadWatchHistory();
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16.0),
        itemCount: state.items.length + (state.isLoading && state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.items.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final item = state.items[index];
          return WatchHistoryItemCard(
            historyItem: item,
            onTap: () {
              // Navigate to details page
              context.push('/details/${item.mediaId}?type=${item.mediaType}');
            },
            onRemove: () {
              ref.read(watchHistoryProvider.notifier).removeFromHistory(item.id);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.history,
            size: 72,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No watch history',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your watch history will appear here',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text('Discover content'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ShimmerLoading(
            width: double.infinity,
            height: 120,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      },
    );
  }
}
