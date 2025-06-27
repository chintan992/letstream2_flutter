import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/models/movie.dart';
import '../../../core/models/tv_show.dart';
import '../../../core/models/video_source.dart';
import '../../../core/services/video_sources_service.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  final dynamic media;
  final int? season;
  final int? episode;
  final String? initialUrl;

  const PlayerScreen({
    super.key,
    required this.media,
    this.season,
    this.episode,
    this.initialUrl,
  });

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late WebViewController _controller;
  List<VideoSource> _videoSources = [];
  VideoSource? _currentSource;
  String? _currentUrl;
  bool _isLoading = true;
  final bool _showControls = true;
  String? _error;


  @override
  void initState() {
    super.initState();
    _setLandscape();
    _loadVideoSources();
  }
  
  Future<void> _loadVideoSources() async {
    try {
      setState(() => _isLoading = true);
      final sources = await ref.read(videoSourcesServiceProvider.future);
      
      setState(() {
        _videoSources = sources;
        if (sources.isNotEmpty) {
          _currentSource = sources.first;
          _currentUrl = _generateUrl(_currentSource!);
        }
        _isLoading = false;
      });
      
      if (_currentUrl != null) {
        _initWebView();
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load video sources: $e';
        _isLoading = false;
      });
    }
  }
  

  String _generateUrl(VideoSource source) {
    final videoService = ref.read(videoSourcesServiceProvider.notifier);
    final mediaId = _getMediaId();
    final isTvShow = _isMediaTvShow();
    
    return videoService.generateStreamingUrl(
      source,
      id: mediaId,
      season: widget.season?.toString(),
      episode: widget.episode?.toString(),
      isTvShow: isTvShow,
    );
  }
  
  bool _isMediaTvShow() {
    if (widget.media is TvShow) return true;
    if (widget.media is Map<String, dynamic>) {
      return widget.media['type'] == 'tv';
    }
    return false;
  }
  
  int _getMediaId() {
    if (widget.media is Movie) {
      return (widget.media as Movie).id;
    } else if (widget.media is TvShow) {
      return (widget.media as TvShow).id;
    } else if (widget.media is Map<String, dynamic>) {
      return widget.media['id'] as int;
    }
    throw Exception('Cannot extract media ID');
  }

  void _initWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..enableZoom(false)
      ..setUserAgent('Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36')
      ..addJavaScriptChannel(
        'console',
        onMessageReceived: (message) {
          debugPrint('JavaScript Console: ${message.message}');
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;
            debugPrint('Navigation request: $url');
            
            // Block requests that try to open new windows (indicated by target)
            if (request.isMainFrame == false) {
              debugPrint('Blocked non-main frame request: $url');
              return NavigationDecision.prevent;
            }
            
            // Allow all other navigation requests
            debugPrint('Allowed navigation: $url');
            return NavigationDecision.navigate;
          },
          onPageStarted: (url) {
            setState(() => _isLoading = true);
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (url) async {
            setState(() => _isLoading = false);
            debugPrint('Page finished loading: $url');
            
            // Inject JavaScript to handle ORB and CORS errors
            await _injectErrorHandling();
          },
          onWebResourceError: (error) {
            setState(() {
              _error = 'Failed to load video: ${error.description}';
              _isLoading = false;
            });
            debugPrint('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(_currentUrl!));
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
  

  void _switchSource(VideoSource source) {
    setState(() {
      _currentSource = source;
      _currentUrl = _generateUrl(source);
      _isLoading = true;
      _error = null;
    });
    _controller.loadRequest(Uri.parse(_currentUrl!));
  }

  void _showSourceSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Video Source',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ..._videoSources.map((source) => ListTile(
              title: Text(
                source.name,
                style: const TextStyle(color: Colors.white),
              ),
              leading: Icon(
                _currentSource?.key == source.key
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: _currentSource?.key == source.key
                    ? Colors.blue
                    : Colors.grey,
              ),
              onTap: () {
                Navigator.pop(context);
                _switchSource(source);
              },
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              Text(
                _error!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadVideoSources,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_currentUrl == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  _resetOrientation();
                  Navigator.of(context).pop();
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black54,
                ),
              ),
            ),
            if (_videoSources.length > 1)
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.switch_video, color: Colors.white),
                  onPressed: _showSourceSelector,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _injectErrorHandling() async {
    try {
      await _controller.runJavaScript('''
        // Override fetch to handle ORB errors
        (function() {
          const originalFetch = window.fetch;
          window.fetch = function(...args) {
            return originalFetch.apply(this, args).catch(error => {
              if (error.message.includes('net::ERR_BLOCKED_BY_ORB') || 
                  error.message.includes('CORS') ||
                  error.message.includes('blocked by CORS policy')) {
                console.log('Suppressed ORB/CORS error:', error.message);
                // Return empty response instead of throwing
                return new Response('', { status: 204, statusText: 'No Content' });
              }
              throw error;
            });
          };
          
          // Override XMLHttpRequest to handle ORB errors
          const originalXHRSend = XMLHttpRequest.prototype.send;
          XMLHttpRequest.prototype.send = function(data) {
            this.addEventListener('error', function(e) {
              if (this.status === 0) {
                console.log('Suppressed XHR ORB/CORS error');
                e.stopPropagation();
                e.preventDefault();
              }
            });
            return originalXHRSend.apply(this, arguments);
          };
          
          // Block known ad scripts and requests
          const blockedDomains = [
            'adsco.re',
            '4.adsco.re',
            '6.adsco.re', 
            'c.adsco.re',
            'googleadservices.com',
            'googlesyndication.com',
            'doubleclick.net'
          ];
          
          // Override createElement to block script tags from ad domains
          const originalCreateElement = document.createElement;
          document.createElement = function(tagName) {
            const element = originalCreateElement.apply(this, arguments);
            if (tagName.toLowerCase() === 'script') {
              const originalSetAttribute = element.setAttribute;
              element.setAttribute = function(name, value) {
                if (name === 'src' && blockedDomains.some(domain => value.includes(domain))) {
                  console.log('Blocked ad script:', value);
                  return;
                }
                return originalSetAttribute.apply(this, arguments);
              };
            }
            return element;
          };
          
          // Suppress console errors from ORB
          const originalConsoleError = console.error;
          console.error = function(...args) {
            const message = args[0];
            if (typeof message === 'string' && (
                message.includes('net::ERR_BLOCKED_BY_ORB') ||
                message.includes('CORS policy') ||
                message.includes('blocked by CORS')
            )) {
              console.log('Suppressed ORB/CORS console error:', message);
              return;
            }
            return originalConsoleError.apply(this, args);
          };
          
          console.log('ORB/CORS error handling injected successfully');
        })();
      ''');
    } catch (e) {
      debugPrint('Failed to inject error handling: $e');
    }
  }

  @override
  void dispose() {
    _resetOrientation();
    super.dispose();
  }
}
