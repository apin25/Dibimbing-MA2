import 'package:fit_movies_app/controllers/movie_list_controller/movie_filter.dart';
import 'package:fit_movies_app/controllers/movie_list_controller/movie_list_controller.dart';
import 'package:fit_movies_app/data/services/movie_service.dart';
import 'package:fit_movies_app/data/services/search_service.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/utils.dart';

class MockMovieService extends Mock implements MovieService {}

class MockSearchService extends Mock implements SearchService {}

void main() {
  group('Movie List Controller Test', () {
    // Setup the controller instance
    late MovieListController controller;
    late MovieService movieService;
    late SearchService searchService;
    
    setUp(() {
      movieService = Get.put(MockMovieService());
      searchService = Get.put(MockSearchService());
      controller = Get.put(MovieListController(movieService: movieService));
    });

    test('When load movie list and list is empty remote state should return error empty list', () async {
      // Arrange
      when(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 1))
          .thenAnswer((_) => Future.value(
          dummyMovieListResponse()
      ));

      // Act
      await controller.getMovieList(MovieFilter.nowPlaying.name, 1);

      // Assert
      verify(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 1)).called(1);

      // Assert
      final remoteState = controller.pagingState;
      expect(remoteState, isA<RemoteStateError>());
    });

    test('When load movie list and list is not empty remote state should return success data', () async {
      // Arrange
      when(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 1))
          .thenAnswer((_) => Future.value(
          dummyMovieListResponse(movies: dummyMovies)
      ));

      // Act
      await controller.getMovieList(MovieFilter.nowPlaying.name, 1);

      // Assert
      verify(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 1)).called(1);

      // Assert
      final remoteState = controller.pagingState;
      expect(remoteState, isA<RemoteStateSuccess>());

      // Assert
      final movieList = controller.movieList;
      expect(movieList, isNotEmpty);
    });

    test('When load next page movie list and list is empty paging state should return error empty list', () async {
      // Arrange
      when(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 2))
          .thenAnswer((_) => Future.value(
          dummyMovieListResponse()
      ));

      // Act
      await controller.getMovieList(MovieFilter.nowPlaying.name, 2);

      // Assert
      verify(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 2)).called(1);

      // Assert
      final pagingState = controller.pagingState;
      expect(pagingState, isA<RemoteStateError>());
    });

    test('When load next page movie list and list is not empty paging state should return success data', () async {
      // Arrange
      when(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 2))
          .thenAnswer((_) => Future.value(
          dummyMovieListResponse(movies: dummyMovies)
      ));

      // Act
      await controller.getMovieList(MovieFilter.nowPlaying.name, 2);

      // Assert
      verify(() => movieService.fetchMovies(MovieFilter.nowPlaying.name, 2)).called(1);

      // Assert
      final pagingState = controller.pagingState;
      expect(pagingState, isA<RemoteStateSuccess>());

      // Assert
      final movieList = controller.movieList;
      expect(movieList, isNotEmpty);
    });

    test('selectedFilter should contain desired value when set a movie filter', () {
      // Arrange
      final filter = MovieFilter.nowPlaying;

      // Act
      controller.setFilter(filter);

      // Assert
      expect(controller.selectedFilter, filter.name);
    });

    test('isSearching should contain desired value when set isSearching', () {
      // Arrange
      final isActive = true;

      // Act
      controller.setIsSearching(isActive);

      // Assert
      expect(controller.isSearching, isActive);
    });

    test('searchQuery should contain desired value when set searchQuery', () {
      // Arrange
      final query = 'Jumbo';

      // Act
      controller.setSearchQuery(query);

      // Assert
      expect(controller.searchQuery, query);
    });

    test('When search movie list and list is empty remote state should return error empty list', () async {
      // Arrange
      final query = 'Jumbo';

      when(() => searchService.searchMovies(query, 1))
          .thenAnswer((_) => Future.value(
          dummyMovieListResponse()
      ));

      // Act
      await controller.searchMovie(query, 1);

      // Assert
      verify(() => searchService.searchMovies(query, 1)).called(1);

      // Assert
      final remoteState = controller.pagingState;
      expect(remoteState, isA<RemoteStateError>());
    });

    test('When search movie list and list is not empty remote state should return success data', () async {
      // Arrange
      final query = 'Jumbo';

      when(() => searchService.searchMovies(query, 1))
          .thenAnswer((_) => Future.value(
          dummyMovieListResponse(movies: dummyMovies)
      ));

      // Act
      await controller.searchMovie(query, 1);

      // Assert
      verify(() => searchService.searchMovies(query, 1)).called(1);

      // Assert
      final remoteState = controller.pagingState;
      expect(remoteState, isA<RemoteStateSuccess>());
    });

    tearDown(() {
      controller.dispose();
      Get.delete<MovieListController>();
      Get.delete<MovieService>();
    });

  });
}