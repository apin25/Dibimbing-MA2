import 'package:fit_movies_app/data/db/favourite_movie.dart';
import 'package:fit_movies_app/data/responses/movie_detail_response.dart';
import 'package:fit_movies_app/data/responses/movie_list_response.dart';

List<Result> dummyMovies = [
  Result(
      adult: false,
      backdropPath: 'backdropPath',
      genreIds: [],
      id: 123,
      originalLanguage: 'originalLanguage',
      originalTitle: 'originalTitle',
      overview: 'overview',
      popularity: 0.0,
      posterPath: 'posterPath',
      releaseDate: DateTime.now(),
      title: 'title',
      video: false,
      voteAverage: 0.0,
      voteCount: 123
  )
];

MovieListResponse dummyMovieListResponse({List<Result> movies = const []}) => MovieListResponse(
  page: 1,
  results: movies,
  totalResults: 0,
  totalPages: 0,
);

MovieDetailResponse dummyMovieDetailResponse = MovieDetailResponse(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [],
  homepage: 'homepage',
  id: 123,
  imdbId: 'imdbId',
  originalLanguage: 'originalLanguage',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 0.0,
  posterPath: 'posterPath',
  releaseDate: DateTime.now(),
  runtime: 120,
  status: 'status',
  tagline: 'tagline',
  title: 'title',
  video: false,
  voteAverage: 0.0,
  voteCount: 123,
  budget: 0,
  revenue: 0,
  productionCompanies: [],
  productionCountries: [],
  spokenLanguages: [],
  originCountry: [],
);

FavouriteMovie dummyFavouriteMovie = FavouriteMovie(
  id: 123,
  title: 'title',
  posterPath: 'posterPath',
  releaseDate: '2023-10-01',
);