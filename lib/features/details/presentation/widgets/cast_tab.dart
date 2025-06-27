import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/cast.dart';
import '../../../../core/services/tmdb_service.dart';

class CastTab extends ConsumerWidget {
  final String mediaType;
  final int mediaId;

  const CastTab({super.key, required this.mediaType, required this.mediaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tmdbService = ref.watch(tmdbServiceProvider);
    final castFuture = tmdbService.getCast(mediaType, mediaId);

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: castFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No cast found.'));
        }

        final cast = snapshot.data!.map((e) => Cast.fromJson(e)).toList();

        return ListView.builder(
          itemCount: cast.length,
          itemBuilder: (context, index) {
            final member = cast[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: member.profilePath != null
                    ? CachedNetworkImageProvider(
                        'https://image.tmdb.org/t/p/w200${member.profilePath}')
                    : null,
                child: member.profilePath == null ? const Icon(Icons.person) : null,
              ),
              title: Text(member.name, style: const TextStyle(color: Colors.white)),
              subtitle: Text(member.character ?? '', style: const TextStyle(color: Colors.white70)),
            );
          },
        );
      },
    );
  }
}
