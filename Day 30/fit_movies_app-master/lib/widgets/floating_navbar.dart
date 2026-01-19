import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:fit_movies_app/widgets/floating_menu_navbar.dart';
import 'package:fit_movies_app/widgets/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FloatingNavbar extends StatefulWidget {
  const FloatingNavbar({super.key});

  @override
  State<FloatingNavbar> createState() => _FloatingNavbarState();
}

class _FloatingNavbarState extends State<FloatingNavbar> {

  MovieListController movieListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 5,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Obx(() {
          bool isSearching = movieListController.isSearching;
          return switch(isSearching) {
            true => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FloatingSearchBar()
            ),
            false => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: MainMenuNavbar(movieListController: movieListController),
              )
            )
          };
        }),
      ),
    );
  }
}