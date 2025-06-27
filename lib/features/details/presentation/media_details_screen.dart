import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/services/tmdb_service.dart';
import 'widgets/about_tab.dart';
import 'widgets/action_buttons.dart';
import 'widgets/cast_tab.dart';
import 'widgets/details_tab_bar.dart';
import 'widgets/media_details_sliver_app_bar.dart';
import 'widgets/media_metadata.dart';
import 'widgets/reviews_tab.dart';

class MediaDetailsScreen extends ConsumerStatefulWidget {
  final String mediaType;
  final int mediaId;
  final String? heroTag;

  const MediaDetailsScreen({
    super.key,
    required this.mediaType,
    required this.mediaId,
    this.heroTag,
  });

  @override
  ConsumerState<MediaDetailsScreen> createState() => _MediaDetailsScreenState();
}

class _MediaDetailsScreenState extends ConsumerState<MediaDetailsScreen>
    with SingleTickerProviderStateMixin {
  dynamic _mediaDetails;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadMediaDetails();
  }

  Future<void> _loadMediaDetails() async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider);
      final details = widget.mediaType == 'movie'
          ? await tmdbService.getMovieDetails(widget.mediaId)
          : await tmdbService.getTvShowDetails(widget.mediaId);

      setState(() {
        _mediaDetails = widget.mediaType == 'movie'
            ? Movie.fromJson(details)
            : TvShow.fromJson(details);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading details: $e')),
        );
      }
    }
  }

  void _playMedia() {
    context.push('/player/${widget.mediaId}?type=${widget.mediaType}');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_mediaDetails == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            MediaDetailsSliverAppBar(
              heroTag: widget.heroTag ?? 'details-backdrop-${_mediaDetails.id}',
              backdropPath: _mediaDetails.backdropPath,
              title: _mediaDetails.title,
              tagline: _mediaDetails.tagline,
            ),
          ];
        },
        body: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final isMovie = widget.mediaType == 'movie';
    final releaseDate =
        isMovie ? _mediaDetails.releaseDate : _mediaDetails.firstAirDate;
    final year = releaseDate != null && releaseDate.isNotEmpty
        ? DateTime.parse(releaseDate).year.toString()
        : null;
    final runtime = isMovie ? _mediaDetails.runtime : null;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaMetadata(
                rating: _mediaDetails.adult ? 'R' : 'PG-13', // Example
                releaseYear: year,
                runtime: runtime != null && runtime > 0 ? '$runtime min' : null,
              ),
              const SizedBox(height: 16),
              ActionButtons(onPlay: _playMedia),
            ],
          ),
        ),
        DetailsTabBar(
          tabController: _tabController,
          tabs: const ['About', 'Cast', 'Reviews', 'Downloads'],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              AboutTab(
                overview: _mediaDetails.overview,
                status: _mediaDetails.status,
                budget: isMovie && _mediaDetails.budget > 0
                    ? NumberFormat.currency(locale: 'en_US', symbol: '\$').format(_mediaDetails.budget)
                    : 'N/A',
                revenue: isMovie && _mediaDetails.revenue > 0
                    ? NumberFormat.currency(locale: 'en_US', symbol: '\$').format(_mediaDetails.revenue)
                    : 'N/A',
                productionCompanies: _mediaDetails.productionCompanies
                    ?.map<String>((c) => c['name'] as String)
                    .toList(),
              ),
              CastTab(mediaType: widget.mediaType, mediaId: widget.mediaId),
              ReviewsTab(mediaType: widget.mediaType, mediaId: widget.mediaId),
              const Center(child: Text('Downloads Tab', style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ],
    );
  }
}
