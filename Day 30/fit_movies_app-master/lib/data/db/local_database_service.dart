import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:hive/hive.dart';

class LocalDatabaseService {
  final Box<FavouriteMovie> box;

  LocalDatabaseService({required this.box});

  Future <void> addFavouriteMovie(FavouriteMovie movie) async {
    await box.put(movie.id, movie);
  }

  Future <void> removeFavouriteMovie(int movieId) async {
    await box.delete(movieId);
  }

  Future<bool> isFavourite(int movieId) async {
    return box.containsKey(movieId);
  }

  Future<List<FavouriteMovie>> getAllFavouriteMovies() async {
    return box.values.toList();
  }
}