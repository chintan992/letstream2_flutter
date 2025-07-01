import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../../../core/models/watch_history_item.dart';

class WatchHistoryItemCard extends StatelessWidget {
  final WatchHistoryItem historyItem;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  const WatchHistoryItemCard({
    super.key,
    required this.historyItem,
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
                    
                    // Season/Episode info for TV shows
                    if (historyItem.mediaType == 'tv' && 
                        (historyItem.seasonNumber != null || historyItem.episodeNumber != null))
                      _buildEpisodeInfo(theme),
                    
                    const SizedBox(height: 8),
                    
                    // Watch time and progress
                    _buildWatchInfo(theme),
                    
                    // Progress bar
        if (historyItem.watchPosition != null && historyItem.watchPosition! > 0)
          _buildProgressBar(theme),
                  ],
                ),
              ),
              
              // Remove button
              if (onRemove != null)
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: onRemove,
                  tooltip: 'Remove from history',
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
    
    if (historyItem.posterPath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w200${historyItem.posterPath}',
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
        historyItem.mediaType == 'tv' ? Icons.tv : Icons.movie,
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
            historyItem.title,
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
            color: historyItem.mediaType == 'tv' 
                ? Colors.blue.withValues(alpha: 0.2)
                : Colors.orange.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            historyItem.mediaType == 'tv' ? 'TV' : 'Movie',
            style: theme.textTheme.bodySmall?.copyWith(
              color: historyItem.mediaType == 'tv' ? Colors.blue : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodeInfo(ThemeData theme) {
    String episodeText = '';
    if (historyItem.seasonNumber != null && historyItem.episodeNumber != null) {
      episodeText = 'S${historyItem.seasonNumber} E${historyItem.episodeNumber}';
    } else if (historyItem.seasonNumber != null) {
      episodeText = 'Season ${historyItem.seasonNumber}';
    } else if (historyItem.episodeNumber != null) {
      episodeText = 'Episode ${historyItem.episodeNumber}';
    }
    
    if (episodeText.isNotEmpty) {
      return Text(
        episodeText,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildWatchInfo(ThemeData theme) {
    final watchedAt = DateFormat('MMM d, y • h:mm a').format(historyItem.createdAt);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Watched $watchedAt',
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        if (historyItem.duration != null)
          Text(
            'Watch time: ${_formatDuration(historyItem.duration!)}',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
      ],
    );
  }

  Widget _buildProgressBar(ThemeData theme) {
    final watchPosition = historyItem.watchPosition!;
    final duration = historyItem.duration ?? 100;
    final progress = watchPosition / duration;
    
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              Text(
                '${((watchPosition / duration) * 100).toInt()}%',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              progress >= 0.9 ? Colors.green : theme.primaryColor,
            ),
            minHeight: 3,
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
