import 'package:flutter/material.dart';

class MediaMetadata extends StatelessWidget {
  final String? rating;
  final String? releaseYear;
  final String? runtime;

  const MediaMetadata({
    super.key,
    this.rating,
    this.releaseYear,
    this.runtime,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (rating != null)
          _MetadataChip(
            icon: Icons.shield_outlined,
            label: rating!,
          ),
        if (releaseYear != null)
          _MetadataChip(
            icon: Icons.calendar_today_outlined,
            label: releaseYear!,
          ),
        if (runtime != null)
          _MetadataChip(
            icon: Icons.timer_outlined,
            label: runtime!,
          ),
      ],
    );
  }
}

class _MetadataChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetadataChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 16,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
