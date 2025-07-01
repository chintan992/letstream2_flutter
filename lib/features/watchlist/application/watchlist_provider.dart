import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/watchlist_item.dart';
import '../../../core/services/watchlist_service.dart';

// Watchlist state class
class WatchlistState {
  final List<WatchlistItem> items;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  WatchlistState({
    required this.items,
    required this.isLoading,
    this.error,
    required this.hasMore,
    this.lastDocument,
  });

  // Initial state
  factory WatchlistState.initial() {
    return WatchlistState(
      items: [],
      isLoading: false,
      error: null,
      hasMore: true,
      lastDocument: null,
    );
  }

  // Copy with method for immutability
  WatchlistState copyWith({
    List<WatchlistItem>? items,
    bool? isLoading,
    String? error,
    bool? hasMore,
    DocumentSnapshot? lastDocument,
    bool clearError = false,
  }) {
    return WatchlistState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}

// Watchlist notifier
class WatchlistNotifier extends StateNotifier<WatchlistState> {
  final WatchlistService _watchlistService;
  
  WatchlistNotifier(this._watchlistService) : super(WatchlistState.initial());

  // Load initial watchlist
  Future<void> loadWatchlist() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final watchlistItems = await _watchlistService.getWatchlist();
      final hasMore = watchlistItems.length == 20; // Default limit in service is 20
      
      state = state.copyWith(
        items: watchlistItems,
        isLoading: false,
        hasMore: hasMore,
        lastDocument: hasMore && watchlistItems.isNotEmpty 
            ? await _getLastDocument(watchlistItems.last) 
            : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Load more watchlist items (pagination)
  Future<void> loadMoreWatchlist() async {
    if (state.isLoading || !state.hasMore) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      final watchlistItems = await _watchlistService.getWatchlist(
        startAfter: state.lastDocument,
      );
      final hasMore = watchlistItems.length == 20;
      
      state = state.copyWith(
        items: [...state.items, ...watchlistItems],
        isLoading: false,
        hasMore: hasMore,
        lastDocument: hasMore && watchlistItems.isNotEmpty 
            ? await _getLastDocument(watchlistItems.last) 
            : state.lastDocument,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Helper to get the last document for pagination
  Future<DocumentSnapshot?> _getLastDocument(WatchlistItem item) async {
    final doc = await FirebaseFirestore.instance
        .collection('watchlist')
        .doc(item.id)
        .get();
    return doc;
  }

  // Add item to watchlist
  Future<void> addToWatchlist({
    required int mediaId,
    required String mediaType,
    required String title,
    String? overview,
    String? backdropPath,
    String? posterPath,
    double? rating,
  }) async {
    try {
      await _watchlistService.addToWatchlist(
        mediaId: mediaId,
        mediaType: mediaType,
        title: title,
        overview: overview,
        backdropPath: backdropPath,
        posterPath: posterPath,
        rating: rating,
      );
      // Refresh the list
      await loadWatchlist();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Remove an item from watchlist
  Future<void> removeFromWatchlist(String itemId) async {
    try {
      await _watchlistService.removeFromWatchlist(itemId);
      state = state.copyWith(
        items: state.items.where((item) => item.id != itemId).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Remove item by media ID and type
  Future<void> removeFromWatchlistByMedia(int mediaId, String mediaType) async {
    try {
      await _watchlistService.removeFromWatchlistByMedia(mediaId, mediaType);
      state = state.copyWith(
        items: state.items.where((item) => 
          !(item.mediaId == mediaId && item.mediaType == mediaType)
        ).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Clear all watchlist
  Future<void> clearWatchlist() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _watchlistService.clearWatchlist();
      state = state.copyWith(
        items: [],
        isLoading: false,
        hasMore: false,
        lastDocument: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Check if item is in watchlist
  Future<bool> isInWatchlist(int mediaId, String mediaType) async {
    try {
      return await _watchlistService.isInWatchlist(mediaId, mediaType);
    } catch (e) {
      return false;
    }
  }
}

// Provider for the watchlist state
final watchlistProvider = StateNotifierProvider<WatchlistNotifier, WatchlistState>((ref) {
  final watchlistService = ref.watch(watchlistServiceProvider);
  return WatchlistNotifier(watchlistService);
});

// Provider to check if specific item is in watchlist
final isInWatchlistProvider = FutureProvider.family<bool, Map<String, dynamic>>((ref, params) async {
  final watchlistService = ref.watch(watchlistServiceProvider);
  return await watchlistService.isInWatchlist(
    params['mediaId'] as int,
    params['mediaType'] as String,
  );
});
