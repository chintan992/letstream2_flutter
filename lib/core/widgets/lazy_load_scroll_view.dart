import 'package:flutter/material.dart';

class LazyLoadScrollView extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onEndOfPage;
  final bool isLoading;
  final ScrollController? scrollController;
  final double threshold;

  const LazyLoadScrollView({
    super.key,
    required this.child,
    required this.onEndOfPage,
    required this.isLoading,
    this.scrollController,
    this.threshold = 200.0,
  });

  @override
  State<LazyLoadScrollView> createState() => _LazyLoadScrollViewState();
}

class _LazyLoadScrollViewState extends State<LazyLoadScrollView> {
  late ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    super.dispose();
  }

  Future<void> _onScroll() async {
    if (!_scrollController.hasClients || widget.isLoading || _isLoadingMore) return;

    final thresholdReached = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels <=
        widget.threshold;

    if (thresholdReached) {
      try {
        setState(() => _isLoadingMore = true);
        await widget.onEndOfPage();
      } finally {
        if (mounted) {
          setState(() => _isLoadingMore = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification) {
          _onScroll();
        }
        return false;
      },
      child: Stack(
        children: [
          widget.child,
          if (_isLoadingMore)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.0),
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
