import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:me_indik_app/infrastructure/provider/api_provider.dart';

class MovieAdapter {
  final Dio dio = Dio(kDioOptions);
 
  Future<Either<MovieError, ListMoviesModel>> fetchPopularMovies(int page) async {
    try {
      final response = await dio.get('/movie/popular?page=$page');
      final model = ListMoviesModel.fromMap(response.data);

    }
  }
}