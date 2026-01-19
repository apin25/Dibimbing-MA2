import 'package:fit_movies_app/controllers/favourite_movie_controller/favourite_movie_controller.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_filter.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:fit_movies_app/data/db/local_database_service.dart';
import 'package:fit_movies_app/widgets/favourite_movie_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouriteMovieScreen extends StatefulWidget {
  const FavouriteMovieScreen({super.key});

  @override
  State<FavouriteMovieScreen> createState() => _FavouriteMovieScreenState();
}

class _FavouriteMovieScreenState extends State<FavouriteMovieScreen> {

  FavouriteMovieController favouriteController = Get.put(
      FavouriteMovieController(
          Get.put(
              LocalDatabaseService(box: Get.find())
          )
      )
  );

  MovieListController movieListController = Get.find();

  @override
  void initState() {

    Future.microtask(() {
      favouriteController.getAllFavouriteMovies();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              movieListController.setFilter(MovieFilter.nowPlaying);
              Navigator.of(context).pop();
            },
          ),
          title: const Text("Favourite Movies"),
        ),
      body: Obx(() {
        return switch (favouriteController.favouriteMovies.isNotEmpty) {
          true => Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7, // Adjust aspect ratio as needed
                ),
                itemCount: favouriteController.favouriteMovies.length,
                itemBuilder: (context, index) {
                  final movie = favouriteController.favouriteMovies[index];

                  return FavouriteMovieItem(movie: movie);
                })
          ),
          _ => const Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("No favourite movies")]
            ),
          )
        };
      })
    );
  }
}