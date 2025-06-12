import 'package:flutter/material.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/models/tv_show.dart';
import '../../../../core/widgets/optimized_image.dart';

class HeroBanner extends StatefulWidget {
  final dynamic media;
  final VoidCallback onPlayPressed;
  final VoidCallback onDetailsPressed;

  const HeroBanner({
    super.key,
    required this.media,
    required this.onPlayPressed,
    required this.onDetailsPressed,
  });

  @override
  State<HeroBanner> createState() => _HeroBannerState();
}

class _HeroBannerState extends State<HeroBanner> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _getBackdropUrl(String? path) {
    if (path == null || path.isEmpty) return null;
    return 'https://image.tmdb.org/t/p/original$path';
  }

  @override
  Widget build(BuildContext context) {
    final backdropPath = widget.media is Movie
        ? widget.media.backdropPath
        : (widget.media is TvShow ? widget.media.backdropPath : null);
    final imageUrl = _getBackdropUrl(backdropPath);
    debugPrint('Hero Banner - Backdrop Path: $backdropPath');
    debugPrint('Hero Banner - Image URL: $imageUrl');
    
    final title = widget.media is Movie ? widget.media.title : (widget.media is TvShow ? widget.media.title : '');
    final overview = widget.media is Movie ? widget.media.overview : (widget.media is TvShow ? widget.media.overview : '');
    final releaseYear = widget.media is Movie
        ? widget.media.releaseDate?.split('-')[0]
        : (widget.media is TvShow ? widget.media.firstAirDate?.split('-')[0] : '');
    final rating = widget.media is Movie
        ? widget.media.voteAverage.toStringAsFixed(1)
        : (widget.media is TvShow ? widget.media.voteAverage.toStringAsFixed(1) : '0.0');
    
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image with blur overlay
            FadeTransition(
              opacity: _fadeAnimation,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  OptimizedImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    enableShimmer: false,
                    heroTag: 'hero_banner_$imageUrl',
                  ),
                  // Dark gradient overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.9),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: const Offset(2.0, 2.0),
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Metadata row
                    Row(
                      children: [
                        if (releaseYear != null && releaseYear.isNotEmpty)
                          Text(
                            releaseYear,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (releaseYear != null && releaseYear.isNotEmpty)
                          const SizedBox(width: 16),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Overview
                    Text(
                      overview,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 24),
                    // Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton.icon(
                          onPressed: widget.onPlayPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Play'),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton.icon(
                          onPressed: widget.onDetailsPressed,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          icon: const Icon(Icons.info_outline),
                          label: const Text('More Info'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
