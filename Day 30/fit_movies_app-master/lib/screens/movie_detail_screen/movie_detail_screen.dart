import 'package:fit_movies_app/controllers/movie_detail_controller/movie_detail_controller.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:fit_movies_app/screens/movie_detail_screen/movie_detail_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_movies_app/data/services/movie_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {

  MovieDetailController movieDetailController = Get.put(
      MovieDetailController(movieService: Get.put(MovieService()))
  );
  
  @override
  void initState() {
    
    Future.microtask(() {
      movieDetailController.getMovieDetail(widget.movieId);
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie Detail"),
      ),
      body: Obx(() {
        return switch (movieDetailController.remoteState) {
          RemoteStateLoading() => const Center(child: CircularProgressIndicator()),
          RemoteStateError(error: var message) => Center(child: Text(message)),
          RemoteStateSuccess<MovieDetailResponse>(data: var response) =>
              MovieDetailContent(movieDetail: response),
          _ => const Center(child: Text('nothing'))
        };
      }),
    );
  }
}