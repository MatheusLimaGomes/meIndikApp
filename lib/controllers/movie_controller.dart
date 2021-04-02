import 'package:dartz/dartz.dart';
import 'package:me_indik_app/Network/adapter/movie_error_adapter.dart';
import 'package:me_indik_app/models/list_movies_model.dart';
import 'package:me_indik_app/models/movie_details_model.dart';
import 'package:me_indik_app/network/adapter/movie_adapter.dart';

class MovieController {
  final _adapter = MovieAdapter();

  ListMoviesModel listMoviesModel;
  MovieError movieError;

  List<MovieModel> get movies => listMoviesModel?.results ?? <MovieModel>[];
  int get moviesCount => movies.length;
  bool get hasMovies => moviesCount >= 0;
  int get totalPages => listMoviesModel?.totalPages ?? 1;
  int get currentPage => listMoviesModel?.page ?? 1;

  Future<Either<MovieError, ListMoviesModel>> fetchPopullarMovies(
      {int page = 1}) async {
    movieError = null;
    final result = await _adapter.fetchPopularMovies(page);

    result.fold(
      (error) => movieError,
      (movie) => {
        if (listMoviesModel == null)
          {listMoviesModel = movie}
        else
          {
            listMoviesModel.page = movie.page,
            listMoviesModel.results.addAll(movie.results)
          }
      },
    );
    return result;
  }
}
