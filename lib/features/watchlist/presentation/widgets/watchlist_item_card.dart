import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/watchlist_item.dart';

class WatchlistItemCard extends StatelessWidget {
  final WatchlistItem watchlistItem;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const WatchlistItemCard({
    super.key,
    required this.watchlistItem,
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
                    if (watchlistItem.overview != null && watchlistItem.overview!.isNotEmpty)
                      _buildOverview(theme),
                    
                    const SizedBox(height: 8),
                    
                    // Rating and added date
                    _buildMetadata(theme),
                  ],
                ),
              ),
              
              // Remove button
              if (onRemove != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onRemove,
                  tooltip: 'Remove from watchlist',
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
    
    if (watchlistItem.posterPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w200${watchlistItem.posterPath}',
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
        watchlistItem.mediaType == 'tv' ? Icons.tv : Icons.movie,
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
            watchlistItem.title,
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
            color: watchlistItem.mediaType == 'tv' 
                ? Colors.blue.withValues(alpha: 0.2)
                : Colors.orange.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            watchlistItem.mediaType == 'tv' ? 'TV' : 'Movie',
            style: theme.textTheme.bodySmall?.copyWith(
              color: watchlistItem.mediaType == 'tv' ? Colors.blue : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOverview(ThemeData theme) {
    return Text(
      watchlistItem.overview!,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.grey[600],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildMetadata(ThemeData theme) {
    final addedAt = DateFormat('MMM d, y • h:mm a').format(watchlistItem.addedAt);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Added $addedAt',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        if (watchlistItem.rating != null && watchlistItem.rating! > 0)
          Row(
            children: [
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                watchlistItem.rating!.toStringAsFixed(1),
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
