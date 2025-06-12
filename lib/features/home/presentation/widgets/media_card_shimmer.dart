import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class MediaCardShimmer extends StatelessWidget {
  const MediaCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 225,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster shimmer
          Expanded(
            child: ShimmerLoading(
              width: 130,
              height: 175,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          // Title shimmer
          const ShimmerLoading(
            width: 110,
            height: 16,
          ),
          const SizedBox(height: 4),
          const ShimmerLoading(
            width: 80,
            height: 16,
          ),
        ],
      ),
    );
  }
}
