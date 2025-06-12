import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediaCard extends StatelessWidget {
  final String? posterPath;
  final String title;
  final VoidCallback onTap;

  const MediaCard({
    super.key,
    required this.posterPath,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 225, // Fixed height for the card
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster Image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: CachedNetworkImage(
                    imageUrl: posterPath != null
                        ? 'https://image.tmdb.org/t/p/w342$posterPath'
                        : 'https://via.placeholder.com/342x513',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[850],
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[850],
                      child: const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ),
            // Title
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4),
              child: SizedBox(
                height: 40, // Fixed height for text
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.2, // Tighter line height
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
