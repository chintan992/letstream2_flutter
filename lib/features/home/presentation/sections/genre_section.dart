import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/services/tmdb_service.dart';
import '../widgets/content_section.dart';

class GenreSection extends ConsumerStatefulWidget {
  const GenreSection({super.key});

  @override
  ConsumerState<GenreSection> createState() => _GenreSectionState();
}

class _GenreSectionState extends ConsumerState<GenreSection> {
  List<Map<String, dynamic>> _genres = [];
  Map<int, List<Movie>> _moviesByGenre = {};
  Map<int, bool> _isLoadingGenre = {};
  Map<int, bool> _hasMoreContent = {};
  Map<int, int> _currentPages = {};
  bool _isLoadingGenres = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadGenres();
  }

  Future<void> _loadGenres() async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      final genres = await tmdbService.getMovieGenres();
      setState(() {
        _genres = genres;
        _isLoadingGenres = false;
      });
      // Load initial movies for each genre
      for (final genre in genres) {
        final genreId = genre['id'] as int;
        _loadMoviesForGenre(genreId);
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load genres';
        _isLoadingGenres = false;
      });
    }
  }

  Future<void> _loadMoviesForGenre(int genreId) async {
    if (_isLoadingGenre[genreId] == true || _hasMoreContent[genreId] == false) {
      return;
    }

    try {
      setState(() => _isLoadingGenre[genreId] = true);
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      final page = _currentPages[genreId] ?? 1;
      final movies = await tmdbService.getMoviesByGenre(genreId, page: page);
      
      if (mounted) {
        setState(() {
          final moviesList = movies.map((m) => Movie.fromJson(m)).toList();
          if (_moviesByGenre.containsKey(genreId)) {
            _moviesByGenre[genreId]!.addAll(moviesList);
          } else {
            _moviesByGenre[genreId] = moviesList;
          }
          _currentPages[genreId] = (page + 1);
          _hasMoreContent[genreId] = movies.isNotEmpty;
          _isLoadingGenre[genreId] = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasMoreContent[genreId] = false;
          _isLoadingGenre[genreId] = false;
        });
      }
    }
  }

  void _navigateToGenreViewAll(int genreId, String genreName) {
    // TODO: Implement genre view all navigation
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (_isLoadingGenres && _genres.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: _genres.map((genre) {
        final genreId = genre['id'] as int;
        final genreName = genre['name'] as String;
        final movies = _moviesByGenre[genreId] ?? [];
        final isLoading = _isLoadingGenre[genreId] ?? false;

        return ContentSection(
          title: genreName,
          mediaList: movies,
          isLoading: isLoading,
          onLoadMore: () => _loadMoviesForGenre(genreId),
          onMediaTap: (movie) => Navigator.pushNamed(
            context, 
            '/details/${(movie as Movie).id}'
          ),
          trailing: TextButton(
            onPressed: () => _navigateToGenreViewAll(genreId, genreName),
            child: const Text('View All'),
          ),
        );
      }).toList(),
    );
  }
}
