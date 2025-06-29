import 'package:freezed_annotation/freezed_annotation.dart';

part 'download_result.freezed.dart';
part 'download_result.g.dart';

@freezed
class DownloadResult with _$DownloadResult {
  const factory DownloadResult({
    required String title,
    required String size,
    required String downloadUrl, 
    required String fileId,
  }) = _DownloadResult;

  factory DownloadResult.fromJson(Map<String, dynamic> json) => DownloadResult(
    title: json['title'] as String? ?? '',
    size: json['size'] as String? ?? '',
    downloadUrl: json['download_url'] as String? ?? '',
    fileId: json['file_id'] as String? ?? '',
  );
  
  const DownloadResult._();
  
  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'size': size,
    'download_url': downloadUrl,
    'file_id': fileId,
  };
}

/// Response model for the download API
@freezed
class DownloadResponse with _$DownloadResponse {
  const factory DownloadResponse({
    required String status,
    required String query,
    required int totalResults,
    required List<DownloadResult> results,
  }) = _DownloadResponse;

  factory DownloadResponse.fromJson(Map<String, dynamic> json) => DownloadResponse(
    status: json['status'] as String? ?? '',
    query: json['query'] as String? ?? '',
    totalResults: json['total_results'] as int? ?? 0,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => DownloadResult.fromJson(e as Map<String, dynamic>))
        .toList() ?? [],
  );
  
  const DownloadResponse._();
  
  @override
  Map<String, dynamic> toJson() => {
    'status': status,
    'query': query,
    'total_results': totalResults,
    'results': results.map((e) => e.toJson()).toList(),
  };
}
