import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/movie.dart';
import '../widgets/trending_section.dart';
import 'genre_section.dart';
import 'new_releases_section.dart';
import 'popular_section.dart';
import 'top_rated_section.dart';

class HomeSections extends ConsumerWidget {
  final ScrollController scrollController;
  final bool isLoading;
  final List<Movie> trendingMovies;  final Function(dynamic) onMovieTap;
  final VoidCallback onLoadMore;

  const HomeSections({
    super.key,
    required this.scrollController,
    required this.isLoading,
    required this.trendingMovies,
    required this.onMovieTap,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.pixels >= notification.metrics.maxScrollExtent * 0.8) {
          onLoadMore();
        }
        return false;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [                TrendingSection(
                  title: 'Trending Now',
                  mediaList: trendingMovies,
                  isLoading: isLoading,
                  onMediaTap: (media) => onMovieTap(media as Movie),
                ),
                const PopularSection(),
                const TopRatedSection(),
                const NewReleasesSection(),
                const GenreSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
