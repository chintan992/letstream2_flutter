import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/services/tmdb_service.dart';
import '../../../core/services/video_sources_service.dart';
import 'widgets/media_backdrop.dart';
import 'widgets/media_info.dart';
import 'widgets/episode_selector.dart';

class MediaDetailsScreen extends ConsumerStatefulWidget {
  final String mediaType;
  final int mediaId;

  const MediaDetailsScreen({
    super.key,
    required this.mediaType,
    required this.mediaId,
  });

  @override
  ConsumerState<MediaDetailsScreen> createState() => _MediaDetailsScreenState();
}

class _MediaDetailsScreenState extends ConsumerState<MediaDetailsScreen> {
  String? _selectedSeason;
  String? _selectedEpisode;
  dynamic _mediaDetails;
  List<Map<String, dynamic>>? _episodes;

  @override
  void initState() {
    super.initState();
    _loadMediaDetails();
  }

  Future<void> _loadMediaDetails() async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      
      final details = widget.mediaType == 'movie'
          ? await tmdbService.getMovieDetails(widget.mediaId)
          : await tmdbService.getTvShowDetails(widget.mediaId);

      setState(() {
        _mediaDetails = widget.mediaType == 'movie'
            ? Movie.fromJson(details)
            : TvShow.fromJson(details);
      });

      if (widget.mediaType == 'tv' && details['seasons'] != null) {
        _loadEpisodes(1); // Load first season by default
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _loadEpisodes(int seasonNumber) async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      final episodes = await tmdbService.getTvSeasonDetails(
        widget.mediaId,
        seasonNumber,
      );

      setState(() {
        _episodes = episodes;
        _selectedSeason = seasonNumber.toString();
        _selectedEpisode = null;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading episodes: $e')),
        );
      }
    }
  }

  void _showSourceSelection() async {
    if (widget.mediaType == 'tv' &&
        (_selectedSeason == null || _selectedEpisode == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a season and episode first'),
        ),
      );
      return;
    }

    final sources = await ref.read(videoSourcesServiceProvider.future);
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: sources.length,
        itemBuilder: (context, index) {
          final source = sources[index];
          return ListTile(
            title: Text(source.name),
            onTap: () {
              final url = ref
                  .read(videoSourcesServiceProvider.notifier)
                  .generateStreamingUrl(
                    source,
                    id: widget.mediaId,
                    season: _selectedSeason,
                    episode: _selectedEpisode,
                    isTvShow: widget.mediaType == 'tv',
                  );
              context.push('/player?url=$url');
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_mediaDetails == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          MediaBackdrop(media: _mediaDetails),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaInfo(media: _mediaDetails),
                  if (widget.mediaType == 'tv') ...[
                    const SizedBox(height: 24),
                    EpisodeSelector(
                      seasons: List.generate(
                        (_mediaDetails as TvShow).numberOfSeasons ?? 0,
                        (index) => (index + 1).toString(),
                      ),
                      episodes: _episodes
                          ?.map((e) => e['episode_number'].toString())
                          .toList(),
                      selectedSeason: _selectedSeason,
                      selectedEpisode: _selectedEpisode,
                      onSeasonChanged: (season) {
                        _loadEpisodes(int.parse(season));
                      },
                      onEpisodeChanged: (episode) {
                        setState(() {
                          _selectedEpisode = episode;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showSourceSelection,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Select Source & Play'),
      ),
    );
  }
}
