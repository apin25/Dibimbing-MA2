import 'package:hive/hive.dart';

part 'favourite_movie.g.dart';

@HiveType(typeId: 1)
class FavouriteMovie {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String releaseDate;

  @HiveField(3)
  final String posterPath;

  FavouriteMovie({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
  });
}