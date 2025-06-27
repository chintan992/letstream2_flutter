import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/review.dart';
import '../../../../core/services/tmdb_service.dart';

class ReviewsTab extends ConsumerWidget {
  final String mediaType;
  final int mediaId;

  const ReviewsTab({super.key, required this.mediaType, required this.mediaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tmdbService = ref.watch(tmdbServiceProvider);
    final reviewsFuture = tmdbService.getReviews(mediaType, mediaId);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: reviewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No reviews found.'));
        }

        final reviews = snapshot.data!.map((e) => Review.fromJson(e)).toList();

        return ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            final review = reviews[index];
            return Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: review.authorDetails?.avatarPath != null
                              ? CachedNetworkImageProvider(
                                  'https://image.tmdb.org/t/p/w200${review.authorDetails!.avatarPath}')
                              : null,
                          child: review.authorDetails?.avatarPath == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          review.author,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(review.content, style: const TextStyle(color: Colors.white70)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
