import 'package:flutter/foundation.dart';
import 'package:movie_apin/data/movie_detail_response.dart';
import 'package:movie_apin/data/movie_list_response.dart';
import 'package:movie_apin/data/network/dio_api_client.dart';
import 'package:movie_apin/data/state/remote_state.dart';

class MovieService {
  final String serviceNamePopular = '/movie/popular';
  final String serviceNameDetail = '/movie';
  final String serviceDiscover = '/discover/movie';
  final http = DioApiClient();

  Future<RemoteState> fetchPopularMovies({int page = 1}) async {
    try {
      if (kDebugMode) {
        print('$serviceNamePopular?page=$page');
      }

      final response = await http.dio.get(
        serviceNamePopular,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        return RemoteStateSuccess<MovieListResponse>(
          MovieListResponse.fromJson(response.data),
        );
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      throw Exception('Failed to load movies: ${e.toString()}');
    }
  }

  Future<RemoteState> fetchMovieDetail(int movieId) async {
    try {
      final response = await http.dio.get('$serviceNameDetail/$movieId');

      if (response.statusCode == 200) {
        return RemoteStateSuccess<MovieDetailResponse>(
          MovieDetailResponse.fromJson(response.data),
        );
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      throw Exception('Failed to load movie details: $e');
    }
  }

  Future<RemoteState> fetchMoviesByGenre(int genreId, {int page = 1}) async {
    try {
      if (kDebugMode) {
        print('$serviceDiscover?with_genres=$genreId&page=$page');
      }

      final response = await http.dio.get(
        serviceDiscover,
        queryParameters: {
          'with_genres': genreId,
          'page': page,
        },
      );

      if (response.statusCode == 200) {
        return RemoteStateSuccess<MovieListResponse>(
          MovieListResponse.fromJson(response.data),
        );
      } else {
        return RemoteStateError("Failed to fetch movies");
      }
    } catch (e) {
      return RemoteStateError("Error: $e");
    }
  }
}