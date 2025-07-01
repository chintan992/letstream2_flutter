import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'favorite_item.freezed.dart';
part 'favorite_item.g.dart';

@freezed
class FavoriteItem with _$FavoriteItem {
  const factory FavoriteItem({
    required String id,
    required String userId,
    required int mediaId,
    required String mediaType, // 'movie' or 'tv'
    required String title,
    String? overview,
    String? backdropPath,
    String? posterPath,
    double? rating,
    required DateTime addedAt,
  }) = _FavoriteItem;

  factory FavoriteItem.fromJson(Map<String, dynamic> json) => _$FavoriteItemFromJson(json);
}

// Extension to add Firestore methods
extension FavoriteItemFirestore on FavoriteItem {
  static DateTime _parseDateTime(dynamic dateTime) {
    if (dateTime is Timestamp) {
      return dateTime.toDate();
    } else if (dateTime is String) {
      return DateTime.parse(dateTime);
    } else {
      throw Exception('Invalid date format: $dateTime');
    }
  }

  static FavoriteItem fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FavoriteItem(
      id: doc.id,
      userId: data['user_id'] as String,
      mediaId: data['media_id'] as int,
      mediaType: data['media_type'] as String,
      title: data['title'] as String,
      overview: data['overview'] as String?,
      backdropPath: data['backdrop_path'] as String?,
      posterPath: data['poster_path'] as String?,
      rating: (data['rating'] as num?)?.toDouble(),
      addedAt: _parseDateTime(data['added_at']),
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
      'rating': rating,
      'added_at': Timestamp.fromDate(addedAt),
    };
  }
}
