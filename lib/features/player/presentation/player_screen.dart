import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/services/video_sources_service.dart';
import '../../../core/models/video_source.dart';
import '../../../core/services/watch_history_service.dart';

class PlayerScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> media;
  final int? season;
  final int? episode;
  final String? title;
  final String? posterPath;

  const PlayerScreen({
    super.key,
    required this.media,
    this.season,
    this.episode,
    this.title,
    this.posterPath,
  });

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> with WidgetsBindingObserver {
  WebViewController? _controller;
  VideoSource? _currentSource;
  bool _showControls = true;
  Timer? _controlsTimer;
  bool _isLoading = true;
  DateTime? _watchStartTime;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setLandscapeOrientation();
    _loadFirstSource();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _resetOrientation();
    _controlsTimer?.cancel();
    _progressTimer?.cancel();
    _saveWatchHistory();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setLandscapeOrientation();
    }
  }

  void _setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void _resetOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  Future<void> _loadFirstSource() async {
    try {
      final sources = await ref.read(videoSourcesServiceProvider.future);
      if (sources.isNotEmpty && mounted) {
        _loadSource(sources.first);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading sources: $e')),
        );
      }
    }
  }

  void _loadSource(VideoSource source) {
    final mediaId = widget.media['id'] as int;
    final isTvShow = widget.media['type'] == 'tv';
    
    try {
      final url = ref.read(videoSourcesServiceProvider.notifier).generateStreamingUrl(
        source,
        id: mediaId,
        season: widget.season?.toString(),
        episode: widget.episode?.toString(),
        isTvShow: isTvShow,
      );

      setState(() {
        _currentSource = source;
        _isLoading = true;
      });

      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (_) {
              setState(() {
                _isLoading = false;
              });
              _startWatchTracking();
            },
            // Strictly control navigation
            onNavigationRequest: (NavigationRequest request) {
              // Only allow the exact initial URL to load
              if (request.url == url) {
                return NavigationDecision.navigate;
              }
              
              // Log and block all other navigation
              //print('Blocked navigation to: ${request.url}');
              
              // For embedded players, allow same-origin iframe src
              final Uri initialUri = Uri.parse(url);
              final Uri requestUri = Uri.parse(request.url);
              if (requestUri.host == initialUri.host && 
                  (request.url.contains('/embed/') || request.url.contains('/player/'))) {
                //print('Allowed player-related navigation: ${request.url}');
                return NavigationDecision.navigate;
              }
              
              // After blocking, reload the original URL if not on current page
              if (_controller != null) {
                _controller!.runJavaScript(
                  "if(window.location.href !== '$url') { window.location.replace('$url'); }"
                );
              }
              
              return NavigationDecision.prevent;
            },
            onWebResourceError: (error) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${error.description}')),
                );
              }
            },
          ),
        )
        ..setBackgroundColor(Colors.black)
        // Set mobile user agent to help prevent some popups
        ..setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1')
        // Disable zooming
        ..enableZoom(false)
        // Execute JavaScript to block popups
        ..addJavaScriptChannel('FlutterApp', onMessageReceived: (JavaScriptMessage message) {
         // print('From JavaScript: ${message.message}');
        })
        ..loadRequest(Uri.parse(url))
        // Run JavaScript to override window.open and block popups
        ..runJavaScript('''
          // Override window.open to prevent popups
          window.open = function(url, target, features) {
            window.FlutterApp.postMessage('Popup blocked: ' + url);
            return null;
          };
          
          // Also block common ad redirects
          const originalCreateElement = document.createElement;
          document.createElement = function(...args) {
            const element = originalCreateElement.apply(document, args);
            if (args[0].toLowerCase() === 'iframe') {
              // Monitor iframe src changes
              const originalSetter = Object.getOwnPropertyDescriptor(HTMLIFrameElement.prototype, 'src').set;
              Object.defineProperty(element, 'src', {
                set(url) {
                  if (url.includes('ad') || url.includes('pop') || url.includes('banner')) {
                    window.FlutterApp.postMessage('Blocked iframe: ' + url);
                    return;
                  }
                  originalSetter.call(this, url);
                }
              });
            }
            return element;
          };
          
          // Block page redirects by monitoring location changes
          const originalAssign = window.location.assign;
          window.location.assign = function(url) {
            window.FlutterApp.postMessage('Blocked redirect to: ' + url);
            return false;
          };
          
          const originalReplace = window.location.replace;
          window.location.replace = function(url) {
            if (url !== '$url') {
              window.FlutterApp.postMessage('Blocked replace to: ' + url);
              return false;
            }
            return originalReplace.call(window.location, url);
          };
          
          // Set up periodic check to ensure we're on the correct URL
          const originalUrl = '$url';
          setInterval(function() {
            if (window.location.href !== originalUrl) {
              window.FlutterApp.postMessage('Detected URL change, restoring original');
              originalReplace.call(window.location, originalUrl);
            }
          }, 1000); // Check every second
        ''');

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    
    _controlsTimer?.cancel();
    if (_showControls) {
      _controlsTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showControls = false;
          });
        }
      });
    }
  }

  void _startWatchTracking() {
    _watchStartTime = DateTime.now();
    
    // Update watch history every 30 seconds
    _progressTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _updateWatchProgress();
    });
  }

  void _updateWatchProgress() {
    if (_watchStartTime == null) return;
    
    final watchDuration = DateTime.now().difference(_watchStartTime!).inSeconds;
    _saveWatchHistoryData(watchDuration: watchDuration);
  }

  void _saveWatchHistory() {
    if (_watchStartTime == null) return;
    
    final watchDuration = DateTime.now().difference(_watchStartTime!).inSeconds;
    // Only save if watched for at least 30 seconds
    if (watchDuration >= 30) {
      _saveWatchHistoryData(watchDuration: watchDuration, isFinal: true);
    }
  }

  void _saveWatchHistoryData({required int watchDuration, bool isFinal = false}) async {
    try {
      final watchHistoryService = ref.read(watchHistoryServiceProvider);
      final mediaId = widget.media['id'] as int;
      final mediaType = widget.media['type'] ?? 'movie';
      
      // Use provided title or fallback to generic title
      final title = widget.title ?? 
                   (mediaType == 'tv' ? 'TV Show Episode' : 'Movie');
      
      await watchHistoryService.addToWatchHistory(
        mediaId: mediaId,
        mediaType: mediaType,
        title: title,
        posterPath: widget.posterPath,
        seasonNumber: widget.season,
        episodeNumber: widget.episode,
        duration: watchDuration,
        // For now, we don't have exact position tracking
        // In a real implementation, you'd get this from the video player
        watchPosition: isFinal ? watchDuration : null,
      );
    } catch (e) {
      // Silently handle errors to not disrupt playback
      debugPrint('Error saving watch history: $e');
    }
  }

  void _showSourceSelection() async {
    final sources = await ref.read(videoSourcesServiceProvider.future);
    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: sources.length,
        itemBuilder: (context, index) {
          final source = sources[index];
          return ListTile(
            title: Text(source.name),
            selected: _currentSource?.key == source.key,
            onTap: () {
              Navigator.pop(context);
              _loadSource(source);
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _toggleControls,
        child: Stack(
          children: [
            // WebView
            _controller != null
                ? WebViewWidget(controller: _controller!)
                : const Center(child: CircularProgressIndicator()),
                
            // Loading indicator
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              
            // Overlay controls
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withValues(alpha: 0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        
                        // Sources button
                        IconButton(
                          icon: const Icon(Icons.playlist_play, color: Colors.white, size: 28),
                          onPressed: _showSourceSelection,
                          tooltip: 'Sources',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
