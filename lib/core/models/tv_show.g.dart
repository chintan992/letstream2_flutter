// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TvShowImpl _$$TvShowImplFromJson(Map<String, dynamic> json) => _$TvShowImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      overview: json['overview'] as String,
      genreIds: (json['genreIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      firstAirDate: json['firstAirDate'] as String,
      voteAverage: (json['voteAverage'] as num).toDouble(),
      voteCount: (json['voteCount'] as num).toInt(),
      numberOfSeasons: (json['numberOfSeasons'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$TvShowImplToJson(_$TvShowImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'genreIds': instance.genreIds,
      'posterPath': instance.posterPath,
      'backdropPath': instance.backdropPath,
      'firstAirDate': instance.firstAirDate,
      'voteAverage': instance.voteAverage,
      'voteCount': instance.voteCount,
      'numberOfSeasons': instance.numberOfSeasons,
    };
