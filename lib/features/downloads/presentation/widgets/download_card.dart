import 'package:flutter/material.dart';
import '../../../../core/models/download_result.dart';
import '../../../../core/utils/download_handler.dart';
import '../../../../core/utils/quality_tags.dart';

/// Widget that displays a single download option with quality tags
class DownloadCard extends StatelessWidget {
  final DownloadResult download;

  const DownloadCard({
    super.key,
    required this.download,
  });

  @override
  Widget build(BuildContext context) {
    final qualityTags = QualityTags.extractQualityTags(download.title);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey.shade900, Colors.black87],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade800,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _launchDownload(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  download.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (qualityTags.isNotEmpty) ...[
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: qualityTags.map((tag) => _buildQualityTag(tag)).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Size: ${download.size}',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _launchDownload(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Download'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQualityTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getTagColor(tag),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Color _getTagColor(String tag) {
    // Categorize tags by type and assign different colors
    if (tag.contains('p') || tag.contains('K') || tag == 'HD' || tag == 'FHD' || tag == 'UHD') {
      return Colors.blue.shade700; // Resolution tags
    } else if (tag.contains('x26') || tag.contains('H.26') || tag == 'HEVC' || tag == 'AVC') {
      return Colors.purple.shade700; // Encoding tags
    } else if (tag == 'BluRay' || tag.contains('WEB') || tag.contains('Rip')) {
      return Colors.orange.shade700; // Source tags
    } else if (tag.contains('HDR') || tag == 'DV' || tag == 'Dolby Vision') {
      return Colors.red.shade700; // HDR tags
    } else if (tag.contains('DTS') || tag.contains('DD') || tag.contains('Atmos')) {
      return Colors.green.shade700; // Audio tags
    } else {
      return Colors.grey.shade700; // Other tags
    }
  }

  Future<void> _launchDownload(BuildContext context) async {
    try {
      // Use the custom download handler to open the download URL in a WebView
      await DownloadHandler.openDownloadUrl(context, download.downloadUrl);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching download: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
