import '../vos/genere_vo.dart';
import '../vos/movie_vo.dart';
import '../vos/person_vo.dart';

abstract class AppModels {
  //// NETWORK
  //HOME
  Future<List<PersonVO>?>? getPopularPerson();
  Future<List<MovieVO>?>? getNowPlaying();
  Future<List<MovieVO>?>? getPopularMovie();
  Future<List<MovieVO>?>? getMoviesByGenere({required int? genereId});
  Future<List<MovieVO>?>? getShowCaseMovies();
  Future<List<GenereVO>?>? getAllGenere();

  //MOVIE DETAIL
  Future<MovieVO?>? getMovieDetailById({required String movieId});
  Future<List<PersonVO>?>? getActors({required String? movieId});
  Future<List<PersonVO>?>? getCrews({required String? movieId});

  ////DAOS
  Stream<List<MovieVO>?>? getNowPlayingFromDatabase();
  Stream<List<MovieVO>?>? getPopularMovieFromDatabase();
  Stream<List<MovieVO>?>? getMoviesByGenereFromDatabase(
      {required int genereId});
  Stream<List<MovieVO>?>? getShowCaseMoviesFromDatabase();
  Stream<MovieVO?>? getMovieDetailByIdFromDatabase({required String movieId});

  Future<List<GenereVO>?>? getAllGenereFromDatabase();
  Future<List<PersonVO>?>? getPopularPersonFromDatabase();
  Future<List<PersonVO>?>? getActorsFromDatabase({required String? movieId});
  Future<List<PersonVO>?>? getCrewsFromDatabase({required String? movieId});
}
