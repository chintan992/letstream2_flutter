import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/watchlist_item.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';

class WatchlistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference get _watchlistCollection => 
      _firestore.collection('watchlist');

  // Get user's watchlist with pagination
  Future<List<WatchlistItem>> getWatchlist({
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    Query query = _watchlistCollection
        .where('user_id', isEqualTo: user.uid)
        .orderBy('added_at', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => WatchlistItemFirestore.fromFirestore(doc))
        .toList();
  }

  // Add an item to watchlist
  Future<void> addToWatchlist({
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

    // Check if this media item already exists in watchlist
    final existingItems = await _watchlistCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    if (existingItems.docs.isNotEmpty) {
      throw Exception('Item already in watchlist');
    }

    // Add new item
    await _watchlistCollection.add({
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

  // Remove an item from watchlist
  Future<void> removeFromWatchlist(String itemId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Get the item first to verify it belongs to the user
    final docSnapshot = await _watchlistCollection.doc(itemId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data['user_id'] == user.uid) {
        await _watchlistCollection.doc(itemId).delete();
      } else {
        throw Exception('Not authorized to delete this item');
      }
    }
  }

  // Remove item by media ID and type
  Future<void> removeFromWatchlistByMedia(int mediaId, String mediaType) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final existingItems = await _watchlistCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    if (existingItems.docs.isNotEmpty) {
      await _watchlistCollection.doc(existingItems.docs.first.id).delete();
    }
  }

  // Check if item is in watchlist
  Future<bool> isInWatchlist(int mediaId, String mediaType) async {
    final user = _auth.currentUser;
    if (user == null) {
      return false;
    }

    final existingItems = await _watchlistCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    return existingItems.docs.isNotEmpty;
  }

  // Clear entire watchlist
  Future<void> clearWatchlist() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final batch = _firestore.batch();
    final querySnapshot = await _watchlistCollection
        .where('user_id', isEqualTo: user.uid)
        .get();

    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // Add movie to watchlist
  Future<void> addMovieToWatchlist(Movie movie) async {
    await addToWatchlist(
      mediaId: movie.id,
      mediaType: 'movie',
      title: movie.title,
      overview: movie.overview,
      backdropPath: movie.backdropPath,
      posterPath: movie.posterPath,
      rating: movie.voteAverage,
    );
  }

  // Add TV show to watchlist
  Future<void> addTvShowToWatchlist(TvShow tvShow) async {
    await addToWatchlist(
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

// Provider for the WatchlistService
final watchlistServiceProvider = Provider<WatchlistService>((ref) {
  return WatchlistService();
});
