import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../models/download_result.dart';

/// Service for handling download-related API calls
class DownloadService {
  static const String _proxyUrl = 'https://vd-src-worker.chintanr21.workers.dev/download';
  static const String _fallbackBaseUrl = 'https://backend.xprime.tv/servers/downloader';

  /// Fetches download links for a movie
  /// 
  /// [movieName] is the name of the movie to search for
  Future<DownloadResponse> getMovieDownloadLinks(String movieName) async {
    final formattedName = _formatQueryName(movieName);
    final baseUrl = await _getBaseUrl();
    final url = Uri.parse('$baseUrl?name=$formattedName');
    
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      return DownloadResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load download links: ${response.statusCode}');
    }
  }

  /// Fetches download links for a TV show episode
  /// 
  /// [showName] is the name of the TV show
  /// [season] is the season number
  /// [episode] is the episode number
  Future<DownloadResponse> getTvShowDownloadLinks(
    String showName, 
    int season, 
    int episode
  ) async {
    final formattedName = _formatQueryName(showName);
    final seasonFormatted = season.toString().padLeft(2, '0');
    final episodeFormatted = episode.toString().padLeft(2, '0');
    final query = '$formattedName S${seasonFormatted}E$episodeFormatted';
    
    final baseUrl = await _getBaseUrl();
    final url = Uri.parse('$baseUrl?name=$query');
    
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      return DownloadResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load TV show download links: ${response.statusCode}');
    }
  }

  /// Formats a query name for the API
  /// 
  /// Replaces spaces with '+' for URL encoding
  String _formatQueryName(String name) {
    return name.trim().replaceAll(' ', '+');
  }

  /// Gets the base URL from the proxy or uses the fallback
  /// 
  /// First tries to fetch the base URL from the proxy, and if that fails,
  /// uses the fallback URL.
  Future<String> _getBaseUrl() async {
    try {
      final response = await http.get(Uri.parse(_proxyUrl));
      
      if (response.statusCode == 200) {
        return response.body.trim();
      }
    } catch (e) {
      // If there's an error fetching from the proxy, use the fallback
      // print('Error fetching base URL from proxy: $e');
    }
    
    return _fallbackBaseUrl;
  }
}

/// Provider for the DownloadService
final downloadServiceProvider = Provider<DownloadService>((ref) {
  return DownloadService();
});
