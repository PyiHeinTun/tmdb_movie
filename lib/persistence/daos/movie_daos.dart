import '../../datas/vos/movie_vo.dart';

abstract class MovieDaos {
  void writeMovieDaos({required List<MovieVO?> movieList});

  Stream<dynamic> getAllMovieStream();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  Stream<List<MovieVO>> getPopularMoviesStream();

  Stream<MovieVO?> getMovieDetailByIdStream({required String movieId});

  Stream<List<MovieVO>> getMovieByGenereStream();

  Stream<List<MovieVO>> getShowCaseMovieStream();

  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getPopularMovies();
  List<MovieVO> getMovieByGenere();
  List<MovieVO> getShowCaseMovie();
  MovieVO? getMovieDetailById({required String movieId});

  Future<void> deleteMovieByGenere();
}
