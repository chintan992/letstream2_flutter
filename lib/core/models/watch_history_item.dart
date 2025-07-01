import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'watch_history_item.freezed.dart';
part 'watch_history_item.g.dart';

@freezed
class WatchHistoryItem with _$WatchHistoryItem {
  const factory WatchHistoryItem({
    required String id,
    required String userId,
    required int mediaId,
    required String mediaType, // 'movie' or 'tv'
    required String title,
    String? overview,
    String? backdropPath,
    String? posterPath,
    String? preferredSource,
    double? rating,
    int? seasonNumber,
    int? episodeNumber,
    required DateTime createdAt,
    int? duration,
    int? watchPosition,
  }) = _WatchHistoryItem;

  factory WatchHistoryItem.fromJson(Map<String, dynamic> json) => _$WatchHistoryItemFromJson(json);
}

// Extension to add Firestore methods
extension WatchHistoryItemFirestore on WatchHistoryItem {
  static DateTime _parseDateTime(dynamic dateTime) {
    if (dateTime is Timestamp) {
      return dateTime.toDate();
    } else if (dateTime is String) {
      return DateTime.parse(dateTime);
    } else {
      throw Exception('Invalid date format: $dateTime');
    }
  }

  static WatchHistoryItem fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return WatchHistoryItem(
      id: doc.id,
      userId: data['user_id'] as String,
      mediaId: data['media_id'] as int,
      mediaType: data['media_type'] as String,
      title: data['title'] as String,
      overview: data['overview'] as String?,
      backdropPath: data['backdrop_path'] as String?,
      posterPath: data['poster_path'] as String?,
      preferredSource: data['preferred_source'] as String?,
      rating: (data['rating'] as num?)?.toDouble(),
      seasonNumber: data['season_number'] as int?,
      episodeNumber: data['episode_number'] as int?,
      createdAt: _parseDateTime(data['created_at']),
      duration: data['duration'] as int?,
      watchPosition: data['watch_position'] as int?,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'user_id': userId,
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
      'created_at': Timestamp.fromDate(createdAt),
      'duration': duration,
      'watch_position': watchPosition,
    };
  }
}
