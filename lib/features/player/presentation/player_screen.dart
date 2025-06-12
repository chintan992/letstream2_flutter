import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';

class PlayerScreen extends StatefulWidget {
  final dynamic media;

  const PlayerScreen({
    super.key,
    required this.media,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late final WebViewController _controller;
  late final String _streamingUrl;
  final List<String> _allowedDomains = [
    'vidsrc.to',
    'vidsrc.me',
    'vidsrc.stream',
    '2embed.to',
    '2embed.org',
    'vidcloud.stream',
    // Add more trusted domains as needed
  ];

  bool _isAllowedDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return _allowedDomains.any((domain) => uri.host.endsWith(domain));
    } catch (e) {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _streamingUrl = _buildStreamingUrl();
    _setLandscape();
    _initWebView();
  }

  String _buildStreamingUrl() {
    if (widget.media is Movie) {
      final movie = widget.media as Movie;
      return 'https://vidsrc.to/embed/movie/${movie.id}';
    } else if (widget.media is TvShow) {
      final tvShow = widget.media as TvShow;
      return 'https://vidsrc.to/embed/tv/${tvShow.id}';
    }
    throw Exception('Unsupported media type');
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            return _isAllowedDomain(request.url)
                ? NavigationDecision.navigate
                : NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(_streamingUrl));
  }

  void _setLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void _resetOrientation() {
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _resetOrientation();
    super.dispose();
  }
}
