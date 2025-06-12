import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tmdb_service.g.dart';

@riverpod
class TmdbService extends _$TmdbService {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  late final String _apiKey;

  @override
  Future<void> build() async {
    _apiKey = dotenv.env['TMDB_API_KEY']!;
  }

  Future<Map<String, dynamic>> _get(String endpoint, {Map<String, String>? params}) async {
    final queryParams = {
      'api_key': _apiKey,
      ...?params,
    };

    final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from TMDB API');
    }
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final data = await _get('/search/movie', params: {'query': query});
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> searchTvShows(String query) async {
    final data = await _get('/search/tv', params: {'query': query});
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final data = await _get('/trending/movie/day');
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getPopularTvShows() async {
    final data = await _get('/tv/popular');
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getNowPlayingMovies() async {
    final data = await _get('/movie/now_playing');
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    return await _get('/movie/$movieId');
  }

  Future<Map<String, dynamic>> getTvShowDetails(int tvId) async {
    return await _get('/tv/$tvId');
  }

  Future<List<Map<String, dynamic>>> getTvSeasonDetails(int tvId, int seasonNumber) async {
    final data = await _get('/tv/$tvId/season/$seasonNumber');
    return List<Map<String, dynamic>>.from(data['episodes']);
  }
}
