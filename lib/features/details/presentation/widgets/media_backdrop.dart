import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/movie.dart';

class MediaBackdrop extends StatelessWidget {
  final dynamic media;

  const MediaBackdrop({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    final backdropPath =
        media is Movie ? media.backdropPath : media.backdropPath;

    return SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (backdropPath != null)
              CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/original$backdropPath',
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(179), // 0.7 * 255 ≈ 179
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
