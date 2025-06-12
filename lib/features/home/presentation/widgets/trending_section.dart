import 'package:flutter/material.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/models/tv_show.dart';
import 'media_card.dart';

class TrendingSection extends StatelessWidget {
  final String title;
  final List<dynamic> mediaList;
  final Function(dynamic) onMediaTap;

  const TrendingSection({
    super.key,
    required this.title,
    required this.mediaList,
    required this.onMediaTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),        SizedBox(
          height: 245, // Increased to accommodate the MediaCard height plus margins
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: mediaList.length,
            itemBuilder: (context, index) {
              final media = mediaList[index];
              final title = media is Movie ? media.title : (media is TvShow ? media.title : '');
              final posterPath = media is Movie
                  ? media.posterPath
                  : (media is TvShow ? media.posterPath : null);

              return MediaCard(
                posterPath: posterPath,
                title: title,
                onTap: () => onMediaTap(media),
              );
            },
          ),
        ),
      ],
    );
  }
}
