import 'package:fit_movies_app/controllers/favourite_movie_controller/favourite_movie_controller.dart';
import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:fit_movies_app/data/db/local_database_service.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FavouriteButtonWidget extends StatefulWidget{
  final MovieDetailResponse movieData;

  const FavouriteButtonWidget({super.key, required this.movieData});

  @override
  State<FavouriteButtonWidget> createState() => _FavouriteButtonWidgetState();
}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget> {

  static final DateFormat formatter = DateFormat("dd MMMM yyyy");

  FavouriteMovieController favouriteController = Get.put(
      FavouriteMovieController(
          Get.put(LocalDatabaseService(box: Get.find()))
      )
  );

  @override
  void initState() {
    Future.microtask(() async {

      await favouriteController.getAllFavouriteMovies();

      if(favouriteController.favouriteMovies.isEmpty) {
        favouriteController.setFavouriteStatus(false);
        return;
      }

      favouriteController.findingFavouriteMovie(widget.movieData.id);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
              favouriteController.isFavourite ?
              Icons.favorite :
              Icons.favorite_border,
              color: Colors.red
          ),
          onPressed: () async {
            favouriteController.isFavourite ?
              await favouriteController.removeFavouriteMovie(widget.movieData.id) :
              await favouriteController.addFavouriteMovie(
                FavouriteMovie(
                  id: widget.movieData.id,
                  title: widget.movieData.title,
                  releaseDate: formatter.format(widget.movieData.releaseDate),
                  posterPath: widget.movieData.posterPath,
                )
              );
          }
      );
    });
  }
}