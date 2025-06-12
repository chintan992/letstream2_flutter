import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/services/tmdb_service.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/hero_banner.dart';
import 'widgets/trending_section.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Movie? _featuredMovie;

  @override
  void initState() {
    super.initState();
    _loadFeaturedContent();
  }

  Future<void> _loadFeaturedContent() async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      final trendingMovies = await tmdbService.getTrendingMovies();
      if (trendingMovies.isNotEmpty) {
        setState(() {
          _featuredMovie = Movie.fromJson(trendingMovies.first);
        });
      }
    } catch (e) {
      debugPrint('Error loading featured content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final tmdbService = ref.watch(tmdbServiceProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(tmdbServiceProvider);
          await _loadFeaturedContent();
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (_featuredMovie != null)
              HeroBanner(
                media: _featuredMovie,
                onPlayPressed: () {
                  context.push('/details/movie/${_featuredMovie!.id}');
                },
                onDetailsPressed: () {
                  context.push('/details/movie/${_featuredMovie!.id}');
                },
              ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: tmdbService.getTrendingMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final movies = snapshot.data!
                    .map((json) => Movie.fromJson(json))
                    .toList();

                return TrendingSection(
                  title: 'Trending Movies',
                  mediaList: movies,
                  onMediaTap: (movie) {
                    if (movie is Movie) {
                      context.push('/details/movie/${movie.id}');
                    }
                  },
                );
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: tmdbService.getPopularTvShows(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final shows = snapshot.data!
                    .map((json) => TvShow.fromJson(json))
                    .toList();

                return TrendingSection(
                  title: 'Popular TV Shows',
                  mediaList: shows,
                  onMediaTap: (show) {
                    if (show is TvShow) {
                      context.push('/details/tv/${show.id}');
                    }
                  },
                );
              },
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: tmdbService.getNowPlayingMovies(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final movies = snapshot.data!
                    .map((json) => Movie.fromJson(json))
                    .toList();

                return TrendingSection(
                  title: 'Now Playing in Theaters',
                  mediaList: movies,
                  onMediaTap: (movie) {
                    if (movie is Movie) {
                      context.push('/details/movie/${movie.id}');
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
