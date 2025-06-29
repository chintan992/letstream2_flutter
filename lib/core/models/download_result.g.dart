// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DownloadResultImpl _$$DownloadResultImplFromJson(Map<String, dynamic> json) =>
    _$DownloadResultImpl(
      title: json['title'] as String,
      size: json['size'] as String,
      downloadUrl: json['downloadUrl'] as String,
      fileId: json['fileId'] as String,
    );

Map<String, dynamic> _$$DownloadResultImplToJson(
        _$DownloadResultImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'size': instance.size,
      'downloadUrl': instance.downloadUrl,
      'fileId': instance.fileId,
    };

_$DownloadResponseImpl _$$DownloadResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$DownloadResponseImpl(
      status: json['status'] as String,
      query: json['query'] as String,
      totalResults: (json['totalResults'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => DownloadResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DownloadResponseImplToJson(
        _$DownloadResponseImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'query': instance.query,
      'totalResults': instance.totalResults,
      'results': instance.results,
    };
