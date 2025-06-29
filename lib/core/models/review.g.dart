// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewImpl _$$ReviewImplFromJson(Map<String, dynamic> json) => _$ReviewImpl(
      id: json['id'] as String,
      author: json['author'] as String,
      content: json['content'] as String,
      authorDetails: json['authorDetails'] == null
          ? null
          : AuthorDetails.fromJson(
              json['authorDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ReviewImplToJson(_$ReviewImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'content': instance.content,
      'authorDetails': instance.authorDetails,
    };

_$AuthorDetailsImpl _$$AuthorDetailsImplFromJson(Map<String, dynamic> json) =>
    _$AuthorDetailsImpl(
      avatarPath: json['avatarPath'] as String?,
    );

Map<String, dynamic> _$$AuthorDetailsImplToJson(_$AuthorDetailsImpl instance) =>
    <String, dynamic>{
      'avatarPath': instance.avatarPath,
    };
