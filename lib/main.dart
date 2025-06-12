import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/home_screen.dart';
import 'features/player/presentation/player_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: '.env');
    if (dotenv.env['TMDB_API_KEY'] == null) {
      throw Exception('TMDB_API_KEY not found in .env file');
    }
    debugPrint('TMDB API Key found: ${dotenv.env['TMDB_API_KEY']?.substring(0, 5)}...');
  } catch (e) {
    debugPrint('Error loading .env file: $e');
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/player',
          builder: (context, state) => PlayerScreen(media: state.extra),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'LetsStream',
      theme: AppTheme.darkTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
