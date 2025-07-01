// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoriteItemImpl _$$FavoriteItemImplFromJson(Map<String, dynamic> json) =>
    _$FavoriteItemImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      mediaId: (json['mediaId'] as num).toInt(),
      mediaType: json['mediaType'] as String,
      title: json['title'] as String,
      overview: json['overview'] as String?,
      backdropPath: json['backdropPath'] as String?,
      posterPath: json['posterPath'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      addedAt: DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$$FavoriteItemImplToJson(_$FavoriteItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'mediaId': instance.mediaId,
      'mediaType': instance.mediaType,
      'title': instance.title,
      'overview': instance.overview,
      'backdropPath': instance.backdropPath,
      'posterPath': instance.posterPath,
      'rating': instance.rating,
      'addedAt': instance.addedAt.toIso8601String(),
    };
