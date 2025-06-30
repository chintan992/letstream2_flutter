import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/player/presentation/player_screen.dart';
import '../../features/movie_list/presentation/movie_list_screen.dart';
import '../../features/details/presentation/media_details_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/application/auth_provider.dart';
import '../../features/profile/presentation/profile_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  return GoRouter(
    initialLocation: isAuthenticated ? '/' : '/login',
    redirect: (context, state) {
      // If the user is not authenticated and not on the login route, redirect to login
      if (!isAuthenticated && state.matchedLocation != '/login') {
        return '/login';
      }
      // If the user is authenticated and on the login route, redirect to home
      if (isAuthenticated && state.matchedLocation == '/login') {
        return '/';
      }
      return null;
    },
    routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id'] ?? '0');
        final params = state.uri.queryParameters;
        final mediaType = params['type'] ?? 'movie';
        return MediaDetailsScreen(
          mediaId: id,
          mediaType: mediaType,
        );
      },
    ),
    GoRoute(
      path: '/player/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id'] ?? '0');
        final params = state.uri.queryParameters;
        final season = int.tryParse(params['season'] ?? '');
        final episode = int.tryParse(params['episode'] ?? '');
        final mediaType = params['type'] ?? 'movie';
        return PlayerScreen(
          media: {'id': id, 'type': mediaType},
          season: season,
          episode: episode,
        );
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
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
  );
});

// For convenience in main.dart, access the router directly
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id'] ?? '0');
        final params = state.uri.queryParameters;
        final mediaType = params['type'] ?? 'movie';
        return MediaDetailsScreen(
          mediaId: id,
          mediaType: mediaType,
        );
      },
    ),
    GoRoute(
      path: '/player/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id'] ?? '0');
        final params = state.uri.queryParameters;
        final season = int.tryParse(params['season'] ?? '');
        final episode = int.tryParse(params['episode'] ?? '');
        final mediaType = params['type'] ?? 'movie';
        return PlayerScreen(
          media: {'id': id, 'type': mediaType},
          season: season,
          episode: episode,
        );
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
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);
