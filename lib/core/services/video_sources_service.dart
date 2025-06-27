import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/video_source.dart';

part 'video_sources_service.g.dart';

@riverpod
class VideoSourcesService extends _$VideoSourcesService {
  final String _sourcesUrl =
      'https://raw.githubusercontent.com/chintan992/letsstream2/refs/heads/main/src/utils/video-sources.json';

  @override
  Future<List<VideoSource>> build() async {
    return await fetchVideoSources();
  }

  Future<List<VideoSource>> fetchVideoSources() async {
    final response = await http.get(Uri.parse(_sourcesUrl));

    if (response.statusCode == 200) {
      final List<dynamic> sourcesList = json.decode(response.body)['videoSources'];
      return sourcesList.map((json) => VideoSource.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load video sources');
    }
  }

  String generateStreamingUrl(VideoSource source, {
    required int id,
    String? season,
    String? episode,
    required bool isTvShow,
  }) {
    if (isTvShow) {
      if (season == null || episode == null) {
        throw ArgumentError('Season and episode are required for TV shows');
      }
      return source.tvUrlPattern
          .replaceAll('{id}', id.toString())
          .replaceAll('{season}', season)
          .replaceAll('{episode}', episode);
    } else {
      return source.movieUrlPattern.replaceAll('{id}', id.toString());
    }
  }
}
