import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import '../../../core/models/movie.dart';
import '../../../core/services/tmdb_service.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/hero_banner.dart';
import 'widgets/hero_banner_shimmer.dart';
import 'sections/home_sections.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Movie? _featuredMovie;
  final List<Movie> _trendingMovies = [];
  bool _isLoading = true;
  String? _error;
  int _currentFeatureIndex = 0;
  Timer? _autoPlayTimer;
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    debugPrint('HomeScreen - initState');
    _loadInitialContent();
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_trendingMovies.length > 1) {
        setState(() {
          _currentFeatureIndex = (_currentFeatureIndex + 1) % _trendingMovies.length;
          _featuredMovie = _trendingMovies[_currentFeatureIndex];
        });
      }
    });
  }
  Future<void> _loadInitialContent() async {
    try {
      setState(() => _isLoading = true);
      final tmdbService = ref.read(tmdbServiceProvider);
      final trendingData = await tmdbService.getTrendingMovies();
        debugPrint('HomeScreen - Got trending data, length: ${trendingData.length}');
      if (trendingData.isNotEmpty) {
        debugPrint('HomeScreen - Processing ${trendingData.length} trending movies');
        final movies = trendingData.map((m) => Movie.fromJson(m)).toList();
        setState(() {
          _trendingMovies.addAll(movies);
          _featuredMovie = movies.first;
          _currentPage++;
          _error = null;
          _isLoading = false;
        });
        _startAutoPlay();      } else {
        debugPrint('HomeScreen - No trending movies found in response');
        setState(() {
          _error = 'No trending movies available';
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      debugPrint('HomeScreen - Error loading initial content: $e');
      debugPrint('Stack trace: $stackTrace');
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreTrending() async {
    if (_isLoading) return;
    try {
      setState(() => _isLoading = true);
      final tmdbService = ref.read(tmdbServiceProvider);
      final movies = await tmdbService.getTrendingMovies(page: _currentPage);
      
      if (mounted) {
        setState(() {
          _trendingMovies.addAll(movies.map((m) => Movie.fromJson(m)).toList());
          _currentPage++;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  dynamic _navigateToDetails(dynamic media) {
    if (media is Movie) {
      context.push('/details/${media.id}');
    }
  }

  void _handlePlayPress() {
    if (_featuredMovie != null) {
      context.push('/player/${_featuredMovie!.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification &&
                  notification.metrics.pixels >= notification.metrics.maxScrollExtent * 0.8) {
                _loadMoreTrending();
              }
              return false;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  if (_isLoading && _featuredMovie == null)
                    const HeroBannerShimmer()
                  else if (_featuredMovie != null)
                    HeroBanner(
                      media: _featuredMovie,
                      onPlayPressed: _handlePlayPress,
                      onDetailsPressed: () => _navigateToDetails(_featuredMovie),
                    ),
                  HomeSections(
                    scrollController: _scrollController,
                    isLoading: _isLoading,
                    trendingMovies: _trendingMovies,
                    onMovieTap: _navigateToDetails,
                    onLoadMore: _loadMoreTrending,
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomAppBar(),
          ),
          if (_error != null)
            Center(
              child: Text(
                _error!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}
