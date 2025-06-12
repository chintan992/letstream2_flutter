import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/services/tmdb_service.dart';
import '../widgets/content_section.dart';

class NewReleasesSection extends ConsumerStatefulWidget {
  const NewReleasesSection({super.key});

  @override
  ConsumerState<NewReleasesSection> createState() => _NewReleasesSectionState();
}

class _NewReleasesSectionState extends ConsumerState<NewReleasesSection> {
  List<Movie> _movies = [];
  bool _isLoading = true;
  bool _hasMore = true;
  int _currentPage = 1;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInitialContent();
  }

  Future<void> _loadInitialContent() async {
    try {
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      final movies = await tmdbService.getNewReleases(page: _currentPage);
      setState(() {
        _movies = movies.map((m) => Movie.fromJson(m)).toList();
        _isLoading = false;
        _currentPage++;
        _hasMore = movies.isNotEmpty;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load new releases';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;
    
    try {
      setState(() => _isLoading = true);
      final tmdbService = ref.read(tmdbServiceProvider.notifier);
      final movies = await tmdbService.getNewReleases(page: _currentPage);
      
      if (mounted) {
        setState(() {
          _movies.addAll(movies.map((m) => Movie.fromJson(m)).toList());
          _currentPage++;
          _hasMore = movies.isNotEmpty;
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


  @override
  Widget build(BuildContext context) {    if (_error != null) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_error!, style: const TextStyle(color: Colors.red)),
      );
    }

    return ContentSection(
      title: 'New Releases',
      mediaList: _movies,
      isLoading: _isLoading,
      onLoadMore: _loadMore,
      onMediaTap: (movie) {
        final context = this.context;
        if (!mounted) return;
        context.go('/movies/${(movie as Movie).id}');
      },
      trailing: TextButton(
        onPressed: () => context.go(
          '/movies/new_releases?title=New Releases',
        ),
        child: const Text(
          'View All',
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
