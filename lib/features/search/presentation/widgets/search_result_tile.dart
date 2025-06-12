import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/movie.dart';

class SearchResultTile extends StatelessWidget {
  final dynamic media;
  final VoidCallback onTap;

  const SearchResultTile({
    super.key,
    required this.media,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final title = media is Movie ? media.title : media.title;
    final posterPath = media is Movie ? media.posterPath : media.posterPath;
    final year = media is Movie
        ? media.releaseDate.substring(0, 4)
        : media.firstAirDate.substring(0, 4);
    final type = media is Movie ? 'Movie' : 'TV Show';

    return ListTile(
      onTap: onTap,
      leading: SizedBox(
        width: 56,
        child: posterPath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w92$posterPath',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(Icons.movie),
              ),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text('$type • $year'),
    );
  }
}
