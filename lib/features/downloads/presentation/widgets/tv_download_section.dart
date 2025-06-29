import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'download_section.dart';

/// Widget that handles season and episode selection for TV show downloads
class TVDownloadSection extends ConsumerStatefulWidget {
  final String showName;
  final int numberOfSeasons;

  const TVDownloadSection({
    super.key,
    required this.showName,
    required this.numberOfSeasons,
  });

  @override
  ConsumerState<TVDownloadSection> createState() => _TVDownloadSectionState();
}

class _TVDownloadSectionState extends ConsumerState<TVDownloadSection> {
  int _selectedSeason = 1;
  int _selectedEpisode = 1;
  final int _episodesPerSeason = 10; // Default number of episodes

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSelectionHeader(),
        Expanded(
          child: _buildDownloadSection(),
        ),
      ],
    );
  }

  Widget _buildSelectionHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade800,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Episode',
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSeasonDropdown(),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildEpisodeDropdown(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeasonDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade700,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: _selectedSeason,
          dropdownColor: Colors.grey.shade900,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          onChanged: (int? newValue) {
            setState(() {
              _selectedSeason = newValue ?? 1;
              _selectedEpisode = 1; // Reset episode when season changes
            });
          },
          items: List.generate(
            widget.numberOfSeasons,
            (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text('Season ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEpisodeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade700,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          isExpanded: true,
          value: _selectedEpisode,
          dropdownColor: Colors.grey.shade900,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.white,
          ),
          onChanged: (int? newValue) {
            setState(() {
              _selectedEpisode = newValue ?? 1;
            });
          },
          items: List.generate(
            _episodesPerSeason,
            (index) => DropdownMenuItem<int>(
              value: index + 1,
              child: Text('Episode ${index + 1}'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadSection() {
    final formattedName = '${widget.showName} S${_formatNumber(_selectedSeason)}E${_formatNumber(_selectedEpisode)}';
    
    return DownloadSection(
      movieName: formattedName,
    );
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }
}
