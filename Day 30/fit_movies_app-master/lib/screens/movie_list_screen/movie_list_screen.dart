import 'dart:async';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:fit_movies_app/data/services/movie_service.dart';
import 'package:fit_movies_app/screens/movie_list_screen/movie_list_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MovieListScreen extends StatefulWidget{
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {

  MovieListController movieListController = Get.put(
      MovieListController(movieService: Get.put(MovieService()))
  );

  @override
  void initState() {

    Future.microtask(() => {
      movieListController.getMovieList(
          movieListController.selectedFilter,
          movieListController.currentPage
      )
    });

    super.initState();
  }

  @override
  void dispose() {
    movieListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MovieListContent(),
    );
  }
}