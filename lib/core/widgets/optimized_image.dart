import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'shimmer_loading.dart';

class OptimizedImage extends StatefulWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool enableShimmer;
  final Widget? errorWidget;
  final String? heroTag;

  const OptimizedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.enableShimmer = true,
    this.errorWidget,
    this.heroTag,
  });

  @override
  State<OptimizedImage> createState() => _OptimizedImageState();
}

class _OptimizedImageState extends State<OptimizedImage> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Widget _buildImage() {
    if (widget.imageUrl == null || widget.imageUrl!.isEmpty) {
      return _buildErrorWidget();
    }

    Widget image = CachedNetworkImage(
      imageUrl: widget.imageUrl!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 300),
      imageBuilder: (context, imageProvider) {
        Widget img = Image(
          image: imageProvider,
          fit: widget.fit,
          width: widget.width,
          height: widget.height,
        );

        if (widget.heroTag != null) {
          img = Hero(
            tag: widget.heroTag!,
            child: img,
          );
        }

        if (!_isLoaded) {
          _fadeController.forward();
          _isLoaded = true;
        }

        return FadeTransition(
          opacity: _fadeController,
          child: img,
        );
      },
      placeholder: (context, url) => widget.enableShimmer
          ? ShimmerLoading(
              width: widget.width ?? 100,
              height: widget.height ?? 100,
              borderRadius: widget.borderRadius,
            )
          : Container(
              width: widget.width ?? 100,
              height: widget.height ?? 100,
              color: Colors.black12,
            ),
      errorWidget: (context, url, error) => _buildErrorWidget(),
    );

    if (widget.borderRadius != null) {
      image = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: image,
      );
    }

    return image;
  }

  Widget _buildErrorWidget() {
    return widget.errorWidget ??
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: widget.borderRadius,
          ),
          child: const Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.white54,
              size: 24,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return _buildImage();
  }
}
