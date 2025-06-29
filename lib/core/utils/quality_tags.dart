/// A utility to extract quality and format tags from download file titles
class QualityTags {
  static final List<String> _knownTags = [
    // Resolution tags
    '480p', '720p', '1080p', '2160p', '4K', '8K', 'HD', 'FHD', 'UHD',
    
    // Encoding tags
    'x264', 'x265', 'H.264', 'H.265', 'HEVC', 'AVC', 'VP9', 'AV1',
    
    // Source tags
    'BluRay', 'WEB-DL', 'WEBRip', 'HDRip', 'BRRip', 'DVDRip', 'HDTV', 'PDTV',
    
    // Audio tags
    'AAC', 'AC3', 'DTS', 'DTS-HD', 'DTS-X', 'TrueHD', 'Atmos', 'FLAC',
    'DD5.1', 'DD+', 'DDP', 'DDP5.1', 'DDP7.1', 'DTS5.1', 'DTS7.1',
    
    // HDR tags
    'HDR', 'HDR10', 'HDR10+', 'DV', 'Dolby Vision', 'HLG',
    
    // Release group qualifiers
    'REMUX', 'IMAX', '3D', 'Half-SBS', 'Full-SBS', 'Half-OU', 'Full-OU'
  ];

  /// Extracts quality tags from a file title
  /// 
  /// Takes a file title string and returns a list of identified quality tags
  static List<String> extractQualityTags(String title) {
    if (title.isEmpty) return [];
    
    final normalizedTitle = title.toUpperCase();
    final foundTags = <String>[];
    
    for (final tag in _knownTags) {
      final upperTag = tag.toUpperCase();
      
      // Check if the tag exists as a standalone word or part of a compound term
      if (normalizedTitle.contains(upperTag)) {
        // Avoid duplicate tags
        if (!foundTags.contains(tag)) {
          foundTags.add(tag);
        }
      }
    }
    
    return foundTags;
  }
}
