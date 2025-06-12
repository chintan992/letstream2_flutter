import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_source.freezed.dart';
part 'video_source.g.dart';

@freezed
class VideoSource with _$VideoSource {
  const factory VideoSource({
    required String key,
    required String name,
    required String movieUrlPattern,
    required String tvUrlPattern,
  }) = _VideoSource;

  factory VideoSource.fromJson(Map<String, dynamic> json) =>
      _$VideoSourceFromJson(json);
}
