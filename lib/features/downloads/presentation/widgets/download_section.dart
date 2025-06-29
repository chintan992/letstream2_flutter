import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/download_result.dart';
import '../../../../core/services/download_service.dart';
import 'download_card.dart';

/// Widget that displays download options for a movie
class DownloadSection extends ConsumerStatefulWidget {
  final String movieName;

  const DownloadSection({
    super.key,
    required this.movieName,
  });

  @override
  ConsumerState<DownloadSection> createState() => _DownloadSectionState();
}

class _DownloadSectionState extends ConsumerState<DownloadSection> {
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  List<DownloadResult> _downloadResults = [];

  @override
  void initState() {
    super.initState();
    _fetchDownloadLinks();
  }

  Future<void> _fetchDownloadLinks() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final downloadService = ref.read(downloadServiceProvider);
      final response = await downloadService.getMovieDownloadLinks(widget.movieName);
      
      if (!mounted) return;
      setState(() {
        _downloadResults = response.results;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading downloads',
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fetchDownloadLinks,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_downloadResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.download_for_offline_outlined,
              color: Colors.grey.shade500,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'No downloads available',
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Could not find any download links for "${widget.movieName}"',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _downloadResults.length,
      itemBuilder: (context, index) {
        return DownloadCard(
          download: _downloadResults[index],
        );
      },
    );
  }
}
