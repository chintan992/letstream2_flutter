import 'package:go_router/go_router.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/player/presentation/player_screen.dart';
import '../../features/movie_list/presentation/movie_list_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/player/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id'] ?? '0');
        return PlayerScreen(media: {'id': id});
      },
    ),
    GoRoute(
      path: '/movies/:type',
      builder: (context, state) {
        final params = state.uri.queryParameters;
        final type = state.pathParameters['type'] ?? '';
        final title = params['title'] ?? 'Movies';
        final genreId = int.tryParse(params['genreId'] ?? '');
        return MovieListScreen(
          title: title,
          listType: type,
          genreId: genreId,
        );
      },
    ),
  ],
);
