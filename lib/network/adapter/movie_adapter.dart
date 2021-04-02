import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:me_indik_app/network/provider/api_provider.dart';
import 'package:me_indik_app/models/list_movies_model.dart';
import 'package:me_indik_app/models/movie_details_model.dart';
import 'movie_error_adapter.dart';

class MovieAdapter {
  final Dio dio = Dio(kDioOptions);

  Future<Either<MovieError, ListMoviesModel>> fetchPopularMovies(
      int page) async {
    try {
      final response = await dio.get('/movie/popular?page=$page');
      final model = ListMoviesModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }

  Future<Either<MovieError, MovieModel>> fetchMovieByID(int id) async {
    try {
      final response = await dio.get('/movie/$id');
      final model = MovieModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      if (error.response != null) {
        return Left(
            MovieRepositoryError(error.response.data['status_message']));
      } else {
        return Left(MovieRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      return Left(MovieRepositoryError(error.toString()));
    }
  }
}
