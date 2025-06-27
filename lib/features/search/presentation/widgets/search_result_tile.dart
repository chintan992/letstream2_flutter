import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/movie.dart';
import '../../../../core/models/tv_show.dart';

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
    final title = media is Movie ? media.title : (media is TvShow ? media.title : 'Unknown Title');
    final posterPath = media is Movie ? media.posterPath : (media is TvShow ? media.posterPath : null);
    
    // Safely extract year from date strings
    String? year;
    if (media is Movie) {
      year = media.releaseDate != null && media.releaseDate!.length >= 4 
          ? media.releaseDate!.substring(0, 4) 
          : 'N/A';
    } else {
      year = media.firstAirDate != null && media.firstAirDate!.length >= 4 
          ? media.firstAirDate!.substring(0, 4) 
          : 'N/A';
    }
    
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
