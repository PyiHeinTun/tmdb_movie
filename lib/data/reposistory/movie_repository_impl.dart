import '../sources/movie_remote_source.dart';
import '../../domain/entity/movie.dart';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/reposistory/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteSource dataSource;
  const MovieRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, Movie>> getMovieDetailById(
      {required String movieId}) async {
    try {
      final Movie data = await dataSource.getMovieDetailById(movieId: movieId);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenere(
      {required int genereId}) async {
    try {
      final List<Movie> data =
          await dataSource.getMoviesByGenere(genereId: genereId);
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final List<Movie> data = await dataSource.getNowPlayingMovies();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final List<Movie> data = await dataSource.getPopularMovies();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getShowCaseMovies() async {
    //If network is unstable Get Data From Cache
    try {
      final List<Movie> data = await dataSource.getShowCaseMovies();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
