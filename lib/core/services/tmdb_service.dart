import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

// Provider for TmdbService
final tmdbServiceProvider = Provider<TmdbService>((ref) => TmdbService());

class TmdbService {
  final String _baseUrl = 'https://api.themoviedb.org/3';
  late final String _apiKey;

  TmdbService() {
    _apiKey = dotenv.env['TMDB_API_KEY'] ?? '';
  }
  Future<Map<String, dynamic>> _get(String endpoint, {Map<String, String>? params}) async {
    try {
      final queryParams = {
        'api_key': _apiKey,
        ...?params,
      };

      final uri = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: queryParams);
      final response = await http.get(uri);
        if (response.statusCode == 200) {
        final decodedData = json.decode(response.body) as Map<String, dynamic>;
        return decodedData;
      } else {
        throw Exception('TMDB API error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      debugPrint('TMDB API request failed: $e');
      rethrow;
    }
  }
  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final data = await _get('/search/movie', params: {'query': query});
    if (!data.containsKey('results')) {
      throw Exception('Missing results key in search movies response');
    }
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> searchTvShows(String query) async {
    final data = await _get('/search/tv', params: {'query': query});
    if (!data.containsKey('results')) {
      throw Exception('Missing results key in search TV shows response');
    }
    return List<Map<String, dynamic>>.from(data['results']);
  }  Future<List<Map<String, dynamic>>> getTrendingMovies({int page = 1}) async {
    try {
      final data = await _get('/trending/movie/week', params: {'page': page.toString()});
      if (!data.containsKey('results')) {
        throw Exception('Missing results key in trending movies response');
      }
      final results = data['results'];
      if (results == null) {
        debugPrint('getTrendingMovies: No results found in API response');
        return [];
      }
      return List<Map<String, dynamic>>.from(results);
    } catch (e, stackTrace) {
      debugPrint('getTrendingMovies failed: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getPopularMovies({int page = 1}) async {
    try {
      final data = await _get('/movie/popular', params: {'page': page.toString()});
      return List<Map<String, dynamic>>.from(data['results']);
    } catch (e) {
      debugPrint('TMDBService - Error fetching popular movies: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getTopRatedMovies({int page = 1}) async {
    try {
      final data = await _get('/movie/top_rated', params: {'page': page.toString()});
      return List<Map<String, dynamic>>.from(data['results']);
    } catch (e) {
      debugPrint('TMDBService - Error fetching top rated movies: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getPopularTvShows({int page = 1}) async {
    try {
      final data = await _get('/tv/popular', params: {'page': page.toString()});
      return List<Map<String, dynamic>>.from(data['results']);
    } catch (e) {
      debugPrint('TMDBService - Error fetching popular TV shows: $e');
      rethrow;
    }
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

  Future<List<Map<String, dynamic>>> getCast(String mediaType, int mediaId) async {
    final data = await _get('/$mediaType/$mediaId/credits');
    return List<Map<String, dynamic>>.from(data['cast']);
  }

  Future<List<Map<String, dynamic>>> getReviews(String mediaType, int mediaId) async {
    final data = await _get('/$mediaType/$mediaId/reviews');
    return List<Map<String, dynamic>>.from(data['results']);
  }

  Future<List<Map<String, dynamic>>> getTvSeasonDetails(int tvId, int seasonNumber) async {
    final data = await _get('/tv/$tvId/season/$seasonNumber');
    return List<Map<String, dynamic>>.from(data['episodes']);
  }
  Future<List<Map<String, dynamic>>> getMovieGenres() async {
    try {
      final data = await _get('/genre/movie/list');
      if (!data.containsKey('genres')) {
        throw Exception('Missing genres key in response');
      }
      return List<Map<String, dynamic>>.from(data['genres']);
    } catch (e) {
      debugPrint('Error fetching genres: $e');
      rethrow;
    }
  }
  Future<List<Map<String, dynamic>>> getMoviesByGenre(int genreId, {int page = 1}) async {
    try {
      final data = await _get('/discover/movie', params: {
        'with_genres': genreId.toString(),
        'page': page.toString(),
        'sort_by': 'popularity.desc'
      });
      if (!data.containsKey('results')) {
        throw Exception('Missing results key in movies by genre response');
      }
      return List<Map<String, dynamic>>.from(data['results']);
    } catch (e) {
      debugPrint('Error fetching movies by genre: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getNewReleases({int page = 1}) async {
    try {
      final data = await _get('/movie/now_playing', params: {
        'page': page.toString(),
        'language': 'en-US'
      });
      return List<Map<String, dynamic>>.from(data['results']);
    } catch (e) {
      debugPrint('Error fetching new releases: $e');
      rethrow;
    }
  }
}
