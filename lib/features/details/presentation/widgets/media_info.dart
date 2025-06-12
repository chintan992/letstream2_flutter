import 'package:flutter/material.dart';
import '../../../../core/models/movie.dart';

class MediaInfo extends StatelessWidget {
  final dynamic media;

  const MediaInfo({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    final title = media is Movie ? media.title : media.title;
    final releaseDate = media is Movie ? media.releaseDate : media.firstAirDate;
    final year = releaseDate.substring(0, 4);
    final rating = (media.voteAverage * 10).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Released: $year • Rating: $rating%',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Text(
          media.overview,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
