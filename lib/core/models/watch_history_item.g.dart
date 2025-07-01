// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WatchHistoryItemImpl _$$WatchHistoryItemImplFromJson(
        Map<String, dynamic> json) =>
    _$WatchHistoryItemImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      mediaId: (json['mediaId'] as num).toInt(),
      mediaType: json['mediaType'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String?,
      backdropPath: json['backdropPath'] as String?,
      posterPath: json['posterPath'] as String?,
      preferredSource: json['preferredSource'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      episodeNumber: (json['episodeNumber'] as num?)?.toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      watchPosition: (json['watchPosition'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$WatchHistoryItemImplToJson(
        _$WatchHistoryItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'mediaId': instance.mediaId,
      'mediaType': instance.mediaType,
      'title': instance.title,
      'overview': instance.overview,
      'backdropPath': instance.backdropPath,
      'posterPath': instance.posterPath,
      'preferredSource': instance.preferredSource,
      'rating': instance.rating,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'createdAt': instance.createdAt.toIso8601String(),
      'duration': instance.duration,
      'watchPosition': instance.watchPosition,
    };
