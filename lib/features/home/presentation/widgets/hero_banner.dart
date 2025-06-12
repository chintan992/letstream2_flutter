import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/models/tv_show.dart';

class HeroBanner extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final backdropPath = media is Movie
        ? media.backdropPath
        : (media is TvShow ? media.backdropPath : null);
    final title = media is Movie ? media.title : (media is TvShow ? media.title : '');
    final overview = media is Movie ? media.overview : (media is TvShow ? media.overview : '');
    final releaseYear = media is Movie
        ? media.releaseDate?.split('-')[0]
        : (media is TvShow ? media.firstAirDate?.split('-')[0] : '');
    final rating = media is Movie
        ? media.voteAverage.toStringAsFixed(1)
        : (media is TvShow ? media.voteAverage.toStringAsFixed(1) : '0.0');

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/original$backdropPath',
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.black,
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.black,
              child: const Icon(Icons.error),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(red: 0, green: 0, blue: 0, alpha: 204), // 0.8 opacity
                  Colors.black,
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (releaseYear != null && releaseYear.isNotEmpty) ...[
                      Text(
                        releaseYear,
                        style: TextStyle(
                          color: Colors.white.withValues(red: 255, green: 255, blue: 255, alpha: 204), // 0.8 opacity
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating,
                      style: TextStyle(
                        color: Colors.white.withValues(red: 255, green: 255, blue: 255, alpha: 204), // 0.8 opacity
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  overview ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white.withValues(red: 255, green: 255, blue: 255, alpha: 204), // 0.8 opacity
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: onPlayPressed,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('Play Now'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onDetailsPressed,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('Details'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
