import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/watch_history_item.dart';
import '../models/movie.dart';
import '../models/tv_show.dart';

class WatchHistoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Collection reference
  CollectionReference get _watchHistoryCollection => 
      _firestore.collection('watchHistory');

  // Get user's watch history with pagination
  Future<List<WatchHistoryItem>> getWatchHistory({
    int limit = 20,
    DocumentSnapshot? startAfter,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    Query query = _watchHistoryCollection
        .where('user_id', isEqualTo: user.uid)
        .orderBy('created_at', descending: true)
        .limit(limit);

    if (startAfter != null) {
      query = query.startAfterDocument(startAfter);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs
        .map((doc) => WatchHistoryItemFirestore.fromFirestore(doc))
        .toList();
  }

  // Add or update an item in watch history
  Future<void> addToWatchHistory({
    required int mediaId,
    required String mediaType,
    required String title,
    String? overview,
    String? backdropPath,
    String? posterPath,
    String? preferredSource,
    double? rating,
    int? seasonNumber,
    int? episodeNumber,
    int? duration,
    int? watchPosition,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Check if this media item already exists in history
    final existingItems = await _watchHistoryCollection
        .where('user_id', isEqualTo: user.uid)
        .where('media_id', isEqualTo: mediaId)
        .where('media_type', isEqualTo: mediaType)
        .get();

    final now = DateTime.now();

    if (existingItems.docs.isNotEmpty) {
      // Update existing item
      final docId = existingItems.docs.first.id;
      await _watchHistoryCollection.doc(docId).update({
        'created_at': Timestamp.fromDate(now),
        'duration': duration,
        'watch_position': watchPosition,
        'season_number': seasonNumber,
        'episode_number': episodeNumber,
        'overview': overview,
        'backdrop_path': backdropPath,
        'preferred_source': preferredSource,
        'rating': rating,
      });
    } else {
      // Add new item
      await _watchHistoryCollection.add({
        'user_id': user.uid,
        'media_id': mediaId,
        'media_type': mediaType,
        'title': title,
        'overview': overview,
        'backdrop_path': backdropPath,
        'poster_path': posterPath,
        'preferred_source': preferredSource,
        'rating': rating,
        'season_number': seasonNumber,
        'episode_number': episodeNumber,
        'created_at': Timestamp.fromDate(now),
        'duration': duration,
        'watch_position': watchPosition,
      });
    }
  }

  // Remove an item from watch history
  Future<void> removeFromWatchHistory(String itemId) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    // Get the item first to verify it belongs to the user
    final docSnapshot = await _watchHistoryCollection.doc(itemId).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      if (data['user_id'] == user.uid) {
        await _watchHistoryCollection.doc(itemId).delete();
      } else {
        throw Exception('Not authorized to delete this item');
      }
    }
  }

  // Clear entire watch history
  Future<void> clearWatchHistory() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }

    final batch = _firestore.batch();
    final querySnapshot = await _watchHistoryCollection
        .where('user_id', isEqualTo: user.uid)
        .get();

    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  // Add movie to watch history
  Future<void> addMovieToHistory(Movie movie, {int? duration, int? watchPosition}) async {
    await addToWatchHistory(
      mediaId: movie.id,
      mediaType: 'movie',
      title: movie.title,
      posterPath: movie.posterPath,
      overview: movie.overview,
      backdropPath: movie.backdropPath,
      rating: movie.voteAverage,
      duration: duration,
      watchPosition: watchPosition,
    );
  }

  // Add TV show to watch history
  Future<void> addTvShowToHistory(
    TvShow tvShow, {
    int? seasonNumber,
    int? episodeNumber,
    int? duration,
    int? watchPosition,
  }) async {
    await addToWatchHistory(
      mediaId: tvShow.id,
      mediaType: 'tv',
      title: tvShow.title,
      posterPath: tvShow.posterPath,
      overview: tvShow.overview,
      backdropPath: tvShow.backdropPath,
      rating: tvShow.voteAverage,
      seasonNumber: seasonNumber,
      episodeNumber: episodeNumber,
      duration: duration,
      watchPosition: watchPosition,
    );
  }
}

// Provider for the WatchHistoryService
final watchHistoryServiceProvider = Provider<WatchHistoryService>((ref) {
  return WatchHistoryService();
});
