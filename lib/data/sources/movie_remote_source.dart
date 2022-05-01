import 'package:dio/dio.dart';
import '../../core/error/exception.dart';
import '../models/movie_model.dart';
import '../models/movie_response_model.dart';
import '../../domain/entity/movie.dart';
import '../../res/rest_end_point.dart';

abstract class MovieRemoteSource {
  Future<List<Movie>> getNowPlayingMovies();
  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getMoviesByGenere({required int genereId});
  Future<List<Movie>> getShowCaseMovies();
  Future<Movie> getMovieDetailById({required String movieId});
}

class MovieRemoteSourceImpl implements MovieRemoteSource {
  @override
  Future<Movie> getMovieDetailById({required String movieId}) async {
    try {
      var response = await Dio()
          .get(EndPoint.getMovieDetailByIdEndPoint(movieId: movieId));
      return MovieModel.fromJson(response.data);
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getMoviesByGenere({required int genereId}) async {
    try {
      var response = await Dio()
          .get(EndPoint.getMoviesByGenereEndPoint(genereId: genereId));
      return MovieResponseModel.fromJson(response.data).movieList;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      var response = await Dio().get(EndPoint.getNowPlayingEndPoint());
      return MovieResponseModel.fromJson(response.data).movieList;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getPopularMovies() async {
    try {
      var response = await Dio().get(EndPoint.getPopularMovieEndPoint());
      return MovieResponseModel.fromJson(response.data).movieList;
    } catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<List<Movie>> getShowCaseMovies() async {
    try {
      var response = await Dio().get(EndPoint.getShowCaseMoviesEndPoint());
      return MovieResponseModel.fromJson(response.data).movieList;
    } catch (_) {
      throw ServerException();
    }
  }
}
