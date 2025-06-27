import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/movie.dart';
import '../../../core/services/tmdb_service.dart';
import '../../../core/widgets/media_grid.dart';

class MovieListScreen extends ConsumerStatefulWidget {
  final String title;
  final String listType;
  final int? genreId;

  const MovieListScreen({
    super.key,
    required this.title,
    required this.listType,
    this.genreId,
  });

  @override
  ConsumerState<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends ConsumerState<MovieListScreen> {
  final List<Movie> _movies = [];
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _hasMore = true;
  int _currentPage = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInitialContent();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      _loadMoreContent();
    }
  }

  Future<void> _loadInitialContent() async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider);
      final moviesData = await _fetchMovies(tmdbService);
      
      if (mounted) {
        setState(() {
          _movies.addAll(moviesData.map((m) => Movie.fromJson(m)).toList());
          _currentPage++;
          _hasMore = moviesData.isNotEmpty;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to load movies';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadMoreContent() async {
    if (_isLoading || !_hasMore) return;

    try {
      setState(() => _isLoading = true);
      final tmdbService = ref.read(tmdbServiceProvider);
      final moviesData = await _fetchMovies(tmdbService);
      
      if (mounted) {
        setState(() {
          _movies.addAll(moviesData.map((m) => Movie.fromJson(m)).toList());
          _currentPage++;
          _hasMore = moviesData.isNotEmpty;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
      }
    }
  }

  Future<List<Map<String, dynamic>>> _fetchMovies(TmdbService tmdbService) async {
    switch (widget.listType) {
      case 'trending':
        return await tmdbService.getTrendingMovies(page: _currentPage);
      case 'popular':
        return await tmdbService.getPopularMovies(page: _currentPage);
      case 'top_rated':
        return await tmdbService.getTopRatedMovies(page: _currentPage);
      case 'new_releases':
        return await tmdbService.getNewReleases(page: _currentPage);
      case 'genre':
        if (widget.genreId != null) {
          return await tmdbService.getMoviesByGenre(widget.genreId!, page: _currentPage);
        }
        return [];
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black.withValues(alpha: 0.5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: _error != null
          ? Center(
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.white),
              ),
            )
          : MediaGrid(
              movies: _movies,
              isLoading: _isLoading,
              hasMore: _hasMore,
              scrollController: _scrollController,
              onMovieTap: (movie) => context.push('/details/${movie.id}'),
            ),
    );
  }
}
