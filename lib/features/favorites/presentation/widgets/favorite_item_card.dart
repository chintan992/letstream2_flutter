import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/favorite_item.dart';

class FavoriteItemCard extends StatelessWidget {
  final FavoriteItem favoriteItem;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const FavoriteItemCard({
    super.key,
    required this.favoriteItem,
    this.onTap,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster Image
              _buildPosterImage(),
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Media Type
                    _buildTitle(theme),
                    const SizedBox(height: 4),
                    
                    // Overview
                    if (favoriteItem.overview != null && favoriteItem.overview!.isNotEmpty)
                      _buildOverview(theme),
                    
                    const SizedBox(height: 8),
                    
                    // Rating and added date
                    _buildMetadata(theme),
                  ],
                ),
              ),
              
              // Favorite heart icon
              const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 4),
              
              // Remove button
              if (onRemove != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onRemove,
                  tooltip: 'Remove from favorites',
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPosterImage() {
    const double imageWidth = 80;
    const double imageHeight = 120;
    
    if (favoriteItem.posterPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w200${favoriteItem.posterPath}',
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            width: imageWidth,
            height: imageHeight,
            color: Colors.grey[300],
            child: const Icon(Icons.movie, size: 32),
          ),
          errorWidget: (context, url, error) => Container(
            width: imageWidth,
            height: imageHeight,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 32),
          ),
        ),
      );
    }
    
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        favoriteItem.mediaType == 'tv' ? Icons.tv : Icons.movie,
        size: 32,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            favoriteItem.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: favoriteItem.mediaType == 'tv' 
                ? Colors.blue.withValues(alpha: 0.2)
                : Colors.orange.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            favoriteItem.mediaType == 'tv' ? 'TV' : 'Movie',
            style: theme.textTheme.bodySmall?.copyWith(
              color: favoriteItem.mediaType == 'tv' ? Colors.blue : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverview(ThemeData theme) {
    return Text(
      favoriteItem.overview!,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.grey[600],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMetadata(ThemeData theme) {
    final addedAt = DateFormat('MMM d, y • h:mm a').format(favoriteItem.addedAt);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Added to favorites $addedAt',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        if (favoriteItem.rating != null && favoriteItem.rating! > 0)
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                favoriteItem.rating!.toStringAsFixed(1),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
