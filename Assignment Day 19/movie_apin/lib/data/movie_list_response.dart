import 'package:movie_apin/models/movie_model.dart';

class MovieListResponse {
  final int page;
  final List<MovieModel> results;
  final int totalResults;
  final int totalPages;

  MovieListResponse({
    required this.page,
    required this.results,
    required this.totalResults,
    required this.totalPages,
  });

  factory MovieListResponse.fromJson(Map<String, dynamic> json) {
    return MovieListResponse(
      page: json['page'] ?? 1,
      results: (json['results'] as List<dynamic>)
          .map((e) => MovieModel.fromJson(e))
          .toList(),
      totalResults: json['total_results'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
    );
  }
}
