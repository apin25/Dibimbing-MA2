
import 'package:fit_movies_app/controllers/movie_detail_controller/movie_detail_controller.dart';
import 'package:fit_movies_app/data/services/movie_service.dart';
import 'package:fit_movies_app/data/state/remote_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/utils.dart';

class MockMovieService extends Mock implements MovieService {}

void main() {
  group('Movie Detail Controller Test', () {
    // Setup the controller instance
    late MovieDetailController controller;
    late MovieService movieService;

    setUp(() {
      movieService = Get.put(MockMovieService());
      controller = Get.put(MovieDetailController(movieService: movieService));
    });

    test('When load movie detail should return movie detail data', () async{
      when(() => movieService.fetchMovieDetails(0))
          .thenAnswer((_) => Future.value(dummyMovieDetailResponse));

      // Act
      await controller.getMovieDetail(0);

      // Assert
      verify(() => movieService.fetchMovieDetails(0)).called(1);

      // Assert
      final remoteState = controller.remoteState;
      expect(remoteState, isA<RemoteStateSuccess>());
    });


    tearDown(() {
      controller.dispose();
      Get.delete<MovieDetailController>();
      Get.delete<MovieService>();
    });
  });
}