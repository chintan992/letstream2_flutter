// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VideoSourceImpl _$$VideoSourceImplFromJson(Map<String, dynamic> json) =>
    _$VideoSourceImpl(
      key: json['key'] as String,
      name: json['name'] as String,
      movieUrlPattern: json['movieUrlPattern'] as String,
      tvUrlPattern: json['tvUrlPattern'] as String,
    );

Map<String, dynamic> _$$VideoSourceImplToJson(_$VideoSourceImpl instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'movieUrlPattern': instance.movieUrlPattern,
      'tvUrlPattern': instance.tvUrlPattern,
    };
