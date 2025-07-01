import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/favorite_item.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';

class FavoritesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference get _favoritesCollection => 
      _firestore.collection('favorites');

  // Get user's favorites with pagination
  Future<List<FavoriteItem>> getFavorites({
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    Query query = _favoritesCollection
        .where('user_id', isEqualTo: user.uid)
        .orderBy('added_at', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => FavoriteItemFirestore.fromFirestore(doc))
        .toList();
  }

  // Add an item to favorites
  Future<void> addToFavorites({
    required int mediaId,
    required String mediaType,
    required String title,
    String? overview,
    String? backdropPath,
    String? posterPath,
    double? rating,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Check if this media item already exists in favorites
    final existingItems = await _favoritesCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    if (existingItems.docs.isNotEmpty) {
      throw Exception('Item already in favorites');
    }

    // Add new item
    await _favoritesCollection.add({
      'user_id': user.uid,
      'media_id': mediaId,
      'media_type': mediaType,
      'title': title,
      'overview': overview,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'rating': rating,
      'added_at': Timestamp.fromDate(DateTime.now()),
    });
  }

  // Remove an item from favorites
  Future<void> removeFromFavorites(String itemId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Get the item first to verify it belongs to the user
    final docSnapshot = await _favoritesCollection.doc(itemId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data['user_id'] == user.uid) {
        await _favoritesCollection.doc(itemId).delete();
      } else {
        throw Exception('Not authorized to delete this item');
      }
    }
  }

  // Remove item by media ID and type
  Future<void> removeFromFavoritesByMedia(int mediaId, String mediaType) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final existingItems = await _favoritesCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    if (existingItems.docs.isNotEmpty) {
      await _favoritesCollection.doc(existingItems.docs.first.id).delete();
    }
  }

  // Check if item is in favorites
  Future<bool> isInFavorites(int mediaId, String mediaType) async {
    final user = _auth.currentUser;
    if (user == null) {
      return false;
    }

    final existingItems = await _favoritesCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    return existingItems.docs.isNotEmpty;
  }

  // Clear entire favorites
  Future<void> clearFavorites() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final batch = _firestore.batch();
    final querySnapshot = await _favoritesCollection
        .where('user_id', isEqualTo: user.uid)
        .get();

    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // Add movie to favorites
  Future<void> addMovieToFavorites(Movie movie) async {
    await addToFavorites(
      mediaId: movie.id,
      mediaType: 'movie',
      title: movie.title,
      overview: movie.overview,
      backdropPath: movie.backdropPath,
      posterPath: movie.posterPath,
      rating: movie.voteAverage,
    );
  }

  // Add TV show to favorites
  Future<void> addTvShowToFavorites(TvShow tvShow) async {
    await addToFavorites(
      mediaId: tvShow.id,
      mediaType: 'tv',
      title: tvShow.title,
      overview: tvShow.overview,
      backdropPath: tvShow.backdropPath,
      posterPath: tvShow.posterPath,
      rating: tvShow.voteAverage,
    );
  }
}

// Provider for the FavoritesService
final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService();
});
