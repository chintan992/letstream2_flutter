import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/watch_history_item.dart';
import '../../../core/services/watch_history_service.dart';

// Watch history state class
class WatchHistoryState {
  final List<WatchHistoryItem> items;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  WatchHistoryState({
    required this.items,
    required this.isLoading,
    this.error,
    required this.hasMore,
    this.lastDocument,
  });

  // Initial state
  factory WatchHistoryState.initial() {
    return WatchHistoryState(
      items: [],
      isLoading: false,
      error: null,
      hasMore: true,
      lastDocument: null,
    );
  }

  // Copy with method for immutability
  WatchHistoryState copyWith({
    List<WatchHistoryItem>? items,
    bool? isLoading,
    String? error,
    bool? hasMore,
    DocumentSnapshot? lastDocument,
    bool clearError = false,
  }) {
    return WatchHistoryState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}

// Watch history notifier
class WatchHistoryNotifier extends StateNotifier<WatchHistoryState> {
  final WatchHistoryService _watchHistoryService;
  
  WatchHistoryNotifier(this._watchHistoryService) : super(WatchHistoryState.initial());

  // Load initial watch history
  Future<void> loadWatchHistory() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final historyItems = await _watchHistoryService.getWatchHistory();
      final hasMore = historyItems.length == 20; // Default limit in service is 20
      
      state = state.copyWith(
        items: historyItems,
        isLoading: false,
        hasMore: hasMore,
        lastDocument: hasMore && historyItems.isNotEmpty 
            ? await _getLastDocument(historyItems.last) 
            : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Load more watch history items (pagination)
  Future<void> loadMoreWatchHistory() async {
    if (state.isLoading || !state.hasMore) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      final historyItems = await _watchHistoryService.getWatchHistory(
        startAfter: state.lastDocument,
      );
      final hasMore = historyItems.length == 20;
      
      state = state.copyWith(
        items: [...state.items, ...historyItems],
        isLoading: false,
        hasMore: hasMore,
        lastDocument: hasMore && historyItems.isNotEmpty 
            ? await _getLastDocument(historyItems.last) 
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
  Future<DocumentSnapshot?> _getLastDocument(WatchHistoryItem item) async {
    final doc = await FirebaseFirestore.instance
        .collection('watchHistory')
        .doc(item.id)
        .get();
    return doc;
  }

  // Remove an item from watch history
  Future<void> removeFromHistory(String itemId) async {
    try {
      await _watchHistoryService.removeFromWatchHistory(itemId);
      state = state.copyWith(
        items: state.items.where((item) => item.id != itemId).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Clear all watch history
  Future<void> clearWatchHistory() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _watchHistoryService.clearWatchHistory();
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
}

// Provider for the watch history state
final watchHistoryProvider = StateNotifierProvider<WatchHistoryNotifier, WatchHistoryState>((ref) {
  final watchHistoryService = ref.watch(watchHistoryServiceProvider);
  return WatchHistoryNotifier(watchHistoryService);
});
