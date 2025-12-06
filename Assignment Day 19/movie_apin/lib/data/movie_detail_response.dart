import 'package:movie_apin/models/genre_model.dart';
import 'package:movie_apin/models/production_company_model.dart';
import 'package:movie_apin/models/production_country.dart';
import 'package:movie_apin/models/spoken_language_model.dart';

class MovieDetailResponse {
  final bool adult;
  final String? backdropPath;
  final Map<String, dynamic>? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final String? imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String? releaseDate;
  final int revenue;
  final int? runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailResponse(
      adult: json["adult"],
      backdropPath: json["backdrop_path"],
      belongsToCollection: json["belongs_to_collection"],
      budget: json["budget"],
      genres: (json["genres"] as List)
          .map((g) => Genre.fromJson(g))
          .toList(),
      homepage: json["homepage"],
      id: json["id"],
      imdbId: json["imdb_id"],
      originCountry: List<String>.from(json["origin_country"] ?? []),
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      overview: json["overview"],
      popularity: (json["popularity"] as num).toDouble(),
      posterPath: json["poster_path"],
      productionCompanies: (json["production_companies"] as List)
          .map((p) => ProductionCompany.fromJson(p))
          .toList(),
      productionCountries: (json["production_countries"] as List)
          .map((p) => ProductionCountry.fromJson(p))
          .toList(),
      releaseDate: json["release_date"],
      revenue: json["revenue"],
      runtime: json["runtime"],
      spokenLanguages: (json["spoken_languages"] as List)
          .map((s) => SpokenLanguage.fromJson(s))
          .toList(),
      status: json["status"],
      tagline: json["tagline"],
      title: json["title"],
      video: json["video"],
      voteAverage: (json["vote_average"] as num).toDouble(),
      voteCount: json["vote_count"],
    );
  }
}
