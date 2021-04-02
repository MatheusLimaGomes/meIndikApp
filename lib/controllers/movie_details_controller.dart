import 'package:dartz/dartz.dart';
import 'package:me_indik_app/models/movie_details_model.dart';
import 'package:me_indik_app/network/adapter/movie_adapter.dart';
import 'package:me_indik_app/network/adapter/movie_error_adapter.dart';

class MovieDetailController {
  final _adapter = MovieAdapter();

  MovieModel movieDetail;
  MovieError movieError;
  bool loading = true;

  Future<Either<MovieError, MovieModel>> fetchMovieById(int id) async {
    movieError = null;
    final result = await _adapter.fetchMovieByID(id);
    result.fold(
      (error) => movieError = error,
      (movie) => {movieDetail = movie},
    );
    return result;
  }
}
