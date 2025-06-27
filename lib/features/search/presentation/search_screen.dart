import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/services/tmdb_service.dart';
import '../../../core/widgets/shimmer_loading.dart';
import 'widgets/search_result_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  Timer? _debounceTimer;
  final _debounceTime = const Duration(milliseconds: 500);

  void _onSearchTextChanged(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
    
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }
    
    setState(() {
      _isLoading = true;
    });
    
    _debounceTimer = Timer(_debounceTime, () => _performSearch(query));
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    try {
      final tmdbService = ref.read(tmdbServiceProvider);
      final movies = await tmdbService.searchMovies(query);
      final tvShows = await tmdbService.searchTvShows(query);

      final List<dynamic> results = [
        ...movies.map((json) => Movie.fromJson(json)),
        ...tvShows.map((json) => TvShow.fromJson(json)),
      ];

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search movies and TV shows...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchTextChanged,
        ),
      ),
      body: _searchController.text.isEmpty
          ? const Center(child: Text('Start typing to search for movies and TV shows'))
          : _isLoading
              ? _buildShimmerLoading()
              : _searchResults.isEmpty
                  ? const Center(child: Text('No results found'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _searchResults.length,
                      itemBuilder: (context, index) {
                        final item = _searchResults[index];
                        return SearchResultTile(
                          media: item,
                          onTap: () {
                            final type = item is Movie ? 'movie' : 'tv';
                            context.push('/details/${item.id}?type=$type');
                          },
                        );
                      },
                    ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }
  
  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            children: [
              // Poster placeholder
              ShimmerLoading(
                width: 56,
                height: 84,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title placeholder
                    ShimmerLoading(
                      width: double.infinity,
                      height: 20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle placeholder
                    ShimmerLoading(
                      width: 120,
                      height: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
