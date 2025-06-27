import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/models/tv_show.dart';
import '../../../../core/widgets/lazy_load_scroll_view.dart';
import 'media_card.dart';

class TrendingSection extends StatefulWidget {
  final String title;
  final List<dynamic> mediaList;
  final Function(dynamic) onMediaTap;
  final Future<void> Function()? onLoadMore;
  final bool isLoading;

  const TrendingSection({
    super.key,
    required this.title,
    required this.mediaList,
    required this.onMediaTap,
    this.onLoadMore,
    this.isLoading = false,
  });

  @override
  State<TrendingSection> createState() => _TrendingSectionState();
}

class _TrendingSectionState extends State<TrendingSection> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
              TextButton(
                onPressed: () => context.go(
                  '/movies/trending?title=Trending Movies',
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = MediaQuery.of(context).size.width;
            final desiredCardWidth = screenWidth < 600 ? 140.0 : 160.0;

            return SizedBox(
              height: desiredCardWidth * 1.7,
              child: LazyLoadScrollView(
                isLoading: widget.isLoading,
                onEndOfPage: widget.onLoadMore ?? () async {},
                scrollController: _scrollController,
                threshold: desiredCardWidth * 2,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.mediaList.length,
                  itemBuilder: (context, index) {
                    final media = widget.mediaList[index];
                    final title =
                        media is Movie ? media.title : (media is TvShow ? media.title : '');
                    final posterPath =
                        media is Movie ? media.posterPath : (media is TvShow ? media.posterPath : null);
                    final rating =
                        media is Movie ? media.voteAverage : (media is TvShow ? media.voteAverage : 0.0);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: MediaCard(
                        posterPath: posterPath,
                        title: title,
                        rating: rating,
                        onTap: () => widget.onMediaTap(media),
                        width: desiredCardWidth,
                        heroTag: "trending-section-${media.id}-$index",
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
