import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'optimized_image.dart';
import 'shimmer_loading.dart';

class EnhancedMediaGrid extends StatefulWidget {
  final List<Movie> movies;
  final bool isLoading;
  final bool hasMore;
  final ScrollController scrollController;
  final Function(Movie) onMovieTap;

  const EnhancedMediaGrid({
    super.key,
    required this.movies,
    required this.isLoading,
    required this.hasMore,
    required this.scrollController,
    required this.onMovieTap,
  });

  @override
  State<EnhancedMediaGrid> createState() => _EnhancedMediaGridState();
}

class _EnhancedMediaGridState extends State<EnhancedMediaGrid> with TickerProviderStateMixin {
  late AnimationController _staggerController;
  final Map<int, AnimationController> _hoverControllers = {};
  final Map<int, Animation<double>> _scaleAnimations = {};
  final Map<int, Animation<double>> _elevationAnimations = {};

  @override
  void initState() {
    super.initState();
    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _staggerController.forward();
  }

  @override
  void dispose() {
    _staggerController.dispose();
    for (final controller in _hoverControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  AnimationController _getHoverController(int index) {
    if (!_hoverControllers.containsKey(index)) {
      _hoverControllers[index] = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      );
      _scaleAnimations[index] = Tween<double>(begin: 1.0, end: 1.05).animate(
        CurvedAnimation(parent: _hoverControllers[index]!, curve: Curves.easeOutCubic),
      );
      _elevationAnimations[index] = Tween<double>(begin: 8.0, end: 24.0).animate(
        CurvedAnimation(parent: _hoverControllers[index]!, curve: Curves.easeOutCubic),
      );
    }
    return _hoverControllers[index]!;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: widget.scrollController,
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 20,
      ),
      itemCount: widget.movies.length + (widget.isLoading ? 6 : 0),
      itemBuilder: (context, index) {
        if (index < widget.movies.length) {
          final movie = widget.movies[index];
          final hoverController = _getHoverController(index);
          final delay = (index % 6) * 100; // Stagger animation delay
          
          return AnimatedBuilder(
            animation: _staggerController,
            builder: (context, child) {
              final staggerOffset = (delay / 1200.0).clamp(0.0, 1.0);
              final adjustedValue = Interval(
                staggerOffset,
                (staggerOffset + 0.4).clamp(0.0, 1.0),
                curve: Curves.easeOutCubic,
              ).transform(_staggerController.value);
              
              return Transform.translate(
                offset: Offset(0, 50 * (1 - adjustedValue)),
                child: Opacity(
                  opacity: adjustedValue,
                  child: MouseRegion(
                    onEnter: (_) => hoverController.forward(),
                    onExit: (_) => hoverController.reverse(),
                    child: AnimatedBuilder(
                      animation: hoverController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimations[index]?.value ?? 1.0,
                          child: GestureDetector(
                            onTap: () => widget.onMovieTap(movie),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    blurRadius: _elevationAnimations[index]?.value ?? 8.0,
                                    offset: Offset(0, (_elevationAnimations[index]?.value ?? 8.0) / 2),
                                  ),
                                  BoxShadow(
                                    color: Colors.red.withValues(alpha: 0.1 * ((_elevationAnimations[index]?.value ?? 8.0) / 24.0)),
                                    blurRadius: (_elevationAnimations[index]?.value ?? 8.0) * 2,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  children: [
                                    Hero(
                                      tag: 'movie-grid-${movie.id}',
                                      child: OptimizedImage(
                                        imageUrl: movie.posterPath != null
                                            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                                            : null,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    // Hover overlay
                                    AnimatedOpacity(
                                      duration: const Duration(milliseconds: 300),
                                      opacity: (_scaleAnimations[index]?.value ?? 1.0) > 1.0 ? 0.3 : 0.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.red.withValues(alpha: 0.2),
                                              Colors.black.withValues(alpha: 0.6),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Play button on hover
                                    if ((_scaleAnimations[index]?.value ?? 1.0) > 1.0)
                                      Center(
                                        child: AnimatedScale(
                                          scale: (_scaleAnimations[index]?.value ?? 1.0) > 1.0 ? 1.0 : 0.0,
                                          duration: const Duration(milliseconds: 200),
                                          child: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: Colors.red.withValues(alpha: 0.9),
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withValues(alpha: 0.3),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                    // Bottom gradient with info
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withValues(alpha: 0.9),
                                              Colors.black.withValues(alpha: 0.6),
                                              Colors.transparent,
                                            ],
                                            stops: const [0.0, 0.7, 1.0],
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              movie.title,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                shadows: [
                                                  Shadow(
                                                    offset: Offset(1, 1),
                                                    blurRadius: 3,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                if (movie.releaseYear != null)
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red.withValues(alpha: 0.8),
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                    child: Text(
                                                      movie.releaseYear.toString(),
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                const Spacer(),
                                                if (movie.voteAverage > 0)
                                                  Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 2,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black.withValues(alpha: 0.7),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                          size: 14,
                                                        ),
                                                        const SizedBox(width: 3),
                                                        Text(
                                                          movie.voteAverage.toStringAsFixed(1),
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // Enhanced shimmer loading with stagger
          final shimmerDelay = ((index - widget.movies.length) * 150).toDouble();
          return AnimatedBuilder(
            animation: _staggerController,
            builder: (context, child) {
              return TweenAnimationBuilder<double>(
                duration: Duration(milliseconds: 800 + shimmerDelay.toInt()),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: 0.8 + (0.2 * value),
                      child: ShimmerLoading(
                        width: MediaQuery.of(context).size.width / 2 - 24,
                        height: (MediaQuery.of(context).size.width / 2 - 24) / 0.65,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }
}
