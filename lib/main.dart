import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await dotenv.load(fileName: '.env');
    if (dotenv.env['TMDB_API_KEY'] == null) {
      throw Exception('TMDB_API_KEY not found in .env file');
    }
    debugPrint('TMDB API Key found: ${dotenv.env['TMDB_API_KEY']?.substring(0, 5)}...');
    
    runApp(const ProviderScope(child: MyApp()));
  } catch (e) {
    debugPrint('Error loading .env file or TMDB API key: $e');
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'Error: Unable to initialize app.\nPlease ensure .env file exists with valid TMDB_API_KEY.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LetsStream',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routerConfig: appRouter,
    );
  }
}
