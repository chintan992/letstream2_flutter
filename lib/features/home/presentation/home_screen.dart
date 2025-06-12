import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/services/tmdb_service.dart';
import 'widgets/media_list_view.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tmdbService = ref.watch(tmdbServiceProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LetsStream'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(tmdbServiceProvider);
        },
        child: ListView(
          children: [
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

                return MediaListView(
                  title: 'Trending Movies',
                  items: movies,
                  onTap: (item) {
                    if (item is Movie) {
                      context.push('/details/movie/${item.id}');
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

                return MediaListView(
                  title: 'Popular TV Shows',
                  items: shows,
                  onTap: (item) {
                    if (item is TvShow) {
                      context.push('/details/tv/${item.id}');
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

                return MediaListView(
                  title: 'Now Playing in Theaters',
                  items: movies,
                  onTap: (item) {
                    if (item is Movie) {
                      context.push('/details/movie/${item.id}');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
