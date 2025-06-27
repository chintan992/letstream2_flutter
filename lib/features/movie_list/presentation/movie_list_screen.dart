import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/movie.dart';
import '../../../core/services/tmdb_service.dart';
import '../../../core/widgets/enhanced_media_grid.dart';

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
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.black.withValues(alpha: 0.95),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '${_movies.length} movies',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.95),
                Colors.black.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
      ),
      body: _error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red.withValues(alpha: 0.7),
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Something went wrong',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _error = null;
                        _isLoading = true;
                        _movies.clear();
                        _currentPage = 1;
                      });
                      _loadInitialContent();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                  ),
                ],
              ),
            )
          : EnhancedMediaGrid(
              movies: _movies,
              isLoading: _isLoading,
              hasMore: _hasMore,
              scrollController: _scrollController,
              onMovieTap: (movie) => context.push('/details/${movie.id}?type=movie'),
            ),
      floatingActionButton: _movies.isNotEmpty ? FloatingActionButton.extended(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
          );
        },
        backgroundColor: Colors.red.withValues(alpha: 0.9),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.keyboard_arrow_up),
        label: const Text('Scroll to Top'),
        elevation: 8,
      ) : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
