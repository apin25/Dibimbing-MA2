import 'package:fit_movies_app/controllers/movie_list_controller/movie_filter.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:fit_movies_app/navigations/navigation_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainMenuNavbar extends StatefulWidget {
  final MovieListController movieListController;

  const MainMenuNavbar({super.key, required this.movieListController});

  @override
  State<MainMenuNavbar> createState() => _MainMenuNavbarState();
}

class _MainMenuNavbarState extends State<MainMenuNavbar> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Obx(() {
            return TextButton(
                onPressed: () {
                  widget.movieListController.setFilter(MovieFilter.nowPlaying);
                },
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: widget.movieListController.selectedFilter ==
                                    MovieFilter.nowPlaying.name
                                    ? Colors.cyan : Colors.white
                            )
                        )
                    )
                ),
                child: Text('Now Playing')
            );
          }),

          Obx(() {
            return TextButton(
                onPressed: () {
                  widget.movieListController.setFilter(MovieFilter.popular);
                },
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: widget.movieListController.selectedFilter ==
                                    MovieFilter.popular.name
                                    ? Colors.cyan : Colors.white
                            )
                        )
                    )
                ),
                child: Text('Popular')
            );
          }),

          Obx(() {
            return TextButton(
                onPressed: () {
                  widget.movieListController.setFilter(MovieFilter.topRated);
                },
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: widget.movieListController.selectedFilter ==
                                    MovieFilter.topRated.name
                                    ? Colors.cyan : Colors.white
                            )
                        )
                    )
                ),
                child: Text('Top Rated')
            );
          }),

          Obx(() {
            return TextButton(
                onPressed: () {
                  widget.movieListController.setFilter(MovieFilter.upcoming);
                },
                style: ButtonStyle(
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: widget.movieListController.selectedFilter ==
                                    MovieFilter.upcoming.name
                                    ? Colors.cyan : Colors.white
                            )
                        )
                    )
                ),
                child: Text('Upcoming')
            );
          }),

          Obx((){
            return IconButton(
              icon: Icon(widget.movieListController.selectedFilter ==
                  MovieFilter.favourite.name
                  ? Icons.favorite : Icons.favorite_border,
                  color: Colors.cyan
              ),
              onPressed: () {
                widget.movieListController.setFilter(MovieFilter.favourite);
                Navigator.pushNamed(context, NavigationRoutes.favourite.name);
              },
            );
          }),

          IconButton(
            icon: Icon(
                Icons.search,
                color: Colors.cyan
            ),
            onPressed: () {
              widget.movieListController
                  .setIsSearching(true);
            },
          ),
        ],
      )
    );
  }
}