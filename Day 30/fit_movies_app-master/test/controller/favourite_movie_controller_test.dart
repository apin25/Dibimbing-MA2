
import 'package:fit_movies_app/controllers/favourite_movie_controller/favourite_movie_controller.dart';
import 'package:fit_movies_app/data/db/local_database_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

import '../utils/utils.dart';

class MockLocalDatabaseService extends Mock implements LocalDatabaseService {}

void main() {
  group('Favourite Movie Controller Test', (){
    //setup the controller instance
    late LocalDatabaseService dbService;
    late FavouriteMovieController controller;

    setUp(() {
      dbService = Get.put(MockLocalDatabaseService());
      controller = Get.put(FavouriteMovieController(dbService));
    });

    test('isFavourite value should be true when db contains desired movieId', () async{
      // Arrange
      when(() => dbService.isFavourite(1))
          .thenAnswer((_) => Future.value(true));

      // Act
      await controller.findingFavouriteMovie(1);

      // Assert
      verify(() => dbService.isFavourite(1)).called(1);

      // Assert
      expect(controller.isFavourite, true);
    });

    test('isFavourite value should be false when db not contains desired movieId', () async{
      // Arrange
      when(() => dbService.isFavourite(1))
          .thenAnswer((_) => Future.value(false));

      // Act
      await controller.findingFavouriteMovie(1);

      // Assert
      verify(() => dbService.isFavourite(1)).called(1);

      // Assert
      expect(controller.isFavourite, false);
    });

    test('isFavourite should be return desired value when set favourite status', () {
      // Act
      controller.setFavouriteStatus(true);

      // Assert
      expect(controller.isFavourite, true);

      // Act
      controller.setFavouriteStatus(false);

      // Assert
      expect(controller.isFavourite, false);
    });

    test('favouriteMovies should contains inserted favourite movie', () async {
      // Arrange
      when(() => dbService.addFavouriteMovie(dummyFavouriteMovie))
          .thenAnswer((_) => Future.value());

      when(() => dbService.getAllFavouriteMovies())
          .thenAnswer((_) => Future.value([dummyFavouriteMovie]));

      // Act
      await controller.addFavouriteMovie(dummyFavouriteMovie);

      // Assert
      verify(() => dbService.addFavouriteMovie(dummyFavouriteMovie)).called(1);

      verify(() => dbService.getAllFavouriteMovies()).called(1);

      expect(controller.favouriteMovies, isNotEmpty);

      expect(controller.favouriteMovies, contains(dummyFavouriteMovie));
    });

    test('favouriteMovies should not contains deleted favourite movie', () async {
      // Arrange
      when(() => dbService.addFavouriteMovie(dummyFavouriteMovie))
          .thenAnswer((_) => Future.value());

      when(() => dbService.getAllFavouriteMovies())
          .thenAnswer((_) => Future.value([]));

      // Act
      await controller.addFavouriteMovie(dummyFavouriteMovie);

      // Assert
      verify(() => dbService.addFavouriteMovie(dummyFavouriteMovie)).called(1);

      verify(() => dbService.getAllFavouriteMovies()).called(1);

      expect(controller.favouriteMovies, isNot(contains(dummyFavouriteMovie)));
    });

    tearDown(() {
      controller.dispose();
      Get.delete<FavouriteMovieController>();
      Get.delete<LocalDatabaseService>();
    });
  });
}