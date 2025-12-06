import 'package:flutter/material.dart';
import 'package:movie_apin/pages/list_movies_page.dart';
import 'package:movie_apin/pages/movie_detail_page.dart';
import 'package:movie_apin/pages/movies_by_category_page.dart';
import 'package:movie_apin/pages/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Flutter Demo',
  initialRoute: '/',
  routes: {
    '/': (context) => SplashScreen(),
    '/home': (context) => ListMoviesPage(),
  },
  onGenerateRoute: (settings) {
    // Route kategori
    if (settings.name == '/category') {
      final args = settings.arguments as Map<String, dynamic>;
      final genreId = args['genreId'];

      return MaterialPageRoute(
        builder: (_) => MovieCategoryPage(genreId: genreId),
      );
    }

    // Route detail
    if (settings.name == '/detail') {
      final args = settings.arguments as Map<String, dynamic>;
      final id = args['id'];

      return MaterialPageRoute(
        builder: (_) => MovieDetailPage(id: id),
      );
    }

    // Default fallback
    return MaterialPageRoute(builder: (_) => SplashScreen());
  },
);

  }
}

