import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/models/favorite_item.dart';
import '../../../core/services/favorites_service.dart';

// Favorites state class
class FavoritesState {
  final List<FavoriteItem> items;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  final DocumentSnapshot? lastDocument;

  FavoritesState({
    required this.items,
    required this.isLoading,
    this.error,
    required this.hasMore,
    this.lastDocument,
  });

  // Initial state
  factory FavoritesState.initial() {
    return FavoritesState(
      items: [],
      isLoading: false,
      error: null,
      hasMore: true,
      lastDocument: null,
    );
  }

  // Copy with method for immutability
  FavoritesState copyWith({
    List<FavoriteItem>? items,
    bool? isLoading,
    String? error,
    bool? hasMore,
    DocumentSnapshot? lastDocument,
    bool clearError = false,
  }) {
    return FavoritesState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : error ?? this.error,
      hasMore: hasMore ?? this.hasMore,
      lastDocument: lastDocument ?? this.lastDocument,
    );
  }
}

// Favorites notifier
class FavoritesNotifier extends StateNotifier<FavoritesState> {
  final FavoritesService _favoritesService;
  
  FavoritesNotifier(this._favoritesService) : super(FavoritesState.initial());

  // Load initial favorites
  Future<void> loadFavorites() async {
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final favoriteItems = await _favoritesService.getFavorites();
      final hasMore = favoriteItems.length == 20; // Default limit in service is 20
      
      state = state.copyWith(
        items: favoriteItems,
        isLoading: false,
        hasMore: hasMore,
        lastDocument: hasMore && favoriteItems.isNotEmpty 
            ? await _getLastDocument(favoriteItems.last) 
            : null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // Load more favorites items (pagination)
  Future<void> loadMoreFavorites() async {
    if (state.isLoading || !state.hasMore) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      final favoriteItems = await _favoritesService.getFavorites(
        startAfter: state.lastDocument,
      );
      final hasMore = favoriteItems.length == 20;
      
      state = state.copyWith(
        items: [...state.items, ...favoriteItems],
        isLoading: false,
        hasMore: hasMore,
        lastDocument: hasMore && favoriteItems.isNotEmpty 
            ? await _getLastDocument(favoriteItems.last) 
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
  Future<DocumentSnapshot?> _getLastDocument(FavoriteItem item) async {
    final doc = await FirebaseFirestore.instance
        .collection('favorites')
        .doc(item.id)
        .get();
    return doc;
  }

  // Add item to favorites
  Future<void> addToFavorites({
    required int mediaId,
    required String mediaType,
    required String title,
    String? overview,
    String? backdropPath,
    String? posterPath,
    double? rating,
  }) async {
    try {
      await _favoritesService.addToFavorites(
        mediaId: mediaId,
        mediaType: mediaType,
        title: title,
        overview: overview,
        backdropPath: backdropPath,
        posterPath: posterPath,
        rating: rating,
      );
      // Refresh the list
      await loadFavorites();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Remove an item from favorites
  Future<void> removeFromFavorites(String itemId) async {
    try {
      await _favoritesService.removeFromFavorites(itemId);
      state = state.copyWith(
        items: state.items.where((item) => item.id != itemId).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Remove item by media ID and type
  Future<void> removeFromFavoritesByMedia(int mediaId, String mediaType) async {
    try {
      await _favoritesService.removeFromFavoritesByMedia(mediaId, mediaType);
      state = state.copyWith(
        items: state.items.where((item) => 
          !(item.mediaId == mediaId && item.mediaType == mediaType)
        ).toList(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  // Clear all favorites
  Future<void> clearFavorites() async {
    state = state.copyWith(isLoading: true);
    
    try {
      await _favoritesService.clearFavorites();
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

  // Check if item is in favorites
  Future<bool> isInFavorites(int mediaId, String mediaType) async {
    try {
      return await _favoritesService.isInFavorites(mediaId, mediaType);
    } catch (e) {
      return false;
    }
  }
}

// Provider for the favorites state
final favoritesProvider = StateNotifierProvider<FavoritesNotifier, FavoritesState>((ref) {
  final favoritesService = ref.watch(favoritesServiceProvider);
  return FavoritesNotifier(favoritesService);
});

// Provider to check if specific item is in favorites
final isInFavoritesProvider = FutureProvider.family<bool, Map<String, dynamic>>((ref, params) async {
  final favoritesService = ref.watch(favoritesServiceProvider);
  return await favoritesService.isInFavorites(
    params['mediaId'] as int,
    params['mediaType'] as String,
  );
});
