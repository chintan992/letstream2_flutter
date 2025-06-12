import 'package:flutter/material.dart';
import '../../../../core/widgets/shimmer_loading.dart';

class HeroBannerShimmer extends StatelessWidget {
  const HeroBannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background shimmer
          const ShimmerLoading(
            width: double.infinity,
            height: double.infinity,
          ),
          // Content shimmer
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title shimmer
                const ShimmerLoading(
                  width: 250,
                  height: 40,
                ),
                const SizedBox(height: 16),
                // Info row shimmer
                Row(
                  children: [
                    const ShimmerLoading(
                      width: 60,
                      height: 20,
                    ),
                    const SizedBox(width: 16),
                    const ShimmerLoading(
                      width: 80,
                      height: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Description shimmer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerLoading(
                      width: double.infinity,
                      height: 16,
                    ),
                    const SizedBox(height: 8),
                    const ShimmerLoading(
                      width: double.infinity,
                      height: 16,
                    ),
                    const SizedBox(height: 8),
                    const ShimmerLoading(
                      width: 200,
                      height: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Buttons shimmer
                Row(
                  children: [
                    const Expanded(
                      child: ShimmerLoading(
                        width: double.infinity,
                        height: 48,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: ShimmerLoading(
                        width: double.infinity,
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
