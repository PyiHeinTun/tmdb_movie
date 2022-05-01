import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entity/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getMoviesByGenere(
      {required int genereId});

  Future<Either<Failure, List<Movie>>> getShowCaseMovies();

  Future<Either<Failure, Movie>> getMovieDetailById({required String movieId});
}
