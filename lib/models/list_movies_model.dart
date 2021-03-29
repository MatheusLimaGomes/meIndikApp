import 'dart:convert';

import 'movie_model.dart';

class ListMoviesModel {
  ListMoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  factory ListMoviesModel.fromJson(String str) =>
      ListMoviesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListMoviesModel.fromMap(Map<String, dynamic> json) => ListMoviesModel(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toMap() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}
