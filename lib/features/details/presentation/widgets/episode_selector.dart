import 'package:flutter/material.dart';

class EpisodeSelector extends StatelessWidget {
  final List<String> seasons;
  final List<String>? episodes;
  final String? selectedSeason;
  final String? selectedEpisode;
  final Function(String) onSeasonChanged;
  final Function(String) onEpisodeChanged;

  const EpisodeSelector({
    super.key,
    required this.seasons,
    this.episodes,
    this.selectedSeason,
    this.selectedEpisode,
    required this.onSeasonChanged,
    required this.onEpisodeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Episode',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Season',
                  border: OutlineInputBorder(),
                ),
                value: selectedSeason,
                items: seasons
                    .map((season) => DropdownMenuItem(
                          value: season,
                          child: Text('Season $season'),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    onSeasonChanged(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Episode',
                  border: OutlineInputBorder(),
                ),
                value: selectedEpisode,
                items: episodes
                    ?.map((episode) => DropdownMenuItem(
                          value: episode,
                          child: Text('Episode $episode'),
                        ))
                    .toList(),
                onChanged: episodes == null
                    ? null
                    : (value) {
                        if (value != null) {
                          onEpisodeChanged(value);
                        }
                      },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
