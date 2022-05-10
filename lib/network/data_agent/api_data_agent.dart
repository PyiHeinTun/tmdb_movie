import '../../datas/vos/genere_vo.dart';
import '../../datas/vos/movie_vo.dart';
import '../../datas/vos/person_vo.dart';

abstract class ApiDataAgent {
  //HOME
  Future<List<PersonVO>?>? getPopularPerson();
  Future<List<MovieVO>?>? getNowPlaying();
  Future<List<MovieVO>?>? getPopularMovie();
  Future<List<MovieVO>?>? getMoviesByGenere({int? genereId});
  Future<List<MovieVO>?>? getShowCaseMovies();
  Future<List<GenereVO>?>? getAllGenere();

  //MOVIE DETAIL
  Future<MovieVO?>? getMovieDetailById({required String movieId});
  Future<List<PersonVO>?>? getActors({String? movieId});
  Future<List<PersonVO>?>? getCrews({String? movieId});
}
