import '../../../datas/vos/movie_vo.dart';
import '../../hive_constants.dart';
import 'package:hive/hive.dart';

import '../movie_daos.dart';

class MovieDaosImpl implements MovieDaos {
  static final MovieDaosImpl _singleton = MovieDaosImpl._internal();

  factory MovieDaosImpl() => _singleton;

  MovieDaosImpl._internal();

  Box<MovieVO> openBox() {
    return Hive.box(kHiveBoxMovie);
  }

  ///REACTIVE PROGRAMMMING WITH STREAM
  @override
  Stream<MovieVO?> getMovieDetailByIdStream({required String movieId}) {
    return Stream.value(getMovieDetailById(movieId: movieId));
  }

  @override
  Stream<List<MovieVO>> getMovieByGenereStream() {
    return Stream.value(getMovieByGenere());
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesStream() {
    return Stream.value(getPopularMovies());
  }

  @override
  Stream<List<MovieVO>> getShowCaseMovieStream() {
    return Stream.value(getShowCaseMovie());
  }

  @override
  Stream<dynamic> getAllMovieStream() {
    return openBox().watch();
  }

  @override
  Future<void> writeMovieDaos({required List<MovieVO?> movieList}) async {
    return openBox().putAll(
      movieList.asMap().map((key, movie) => MapEntry(movie?.id, movie!)),
    );
  }

  /// NORMAL RETURN LIST
  @override
  List<MovieVO> getMovieByGenere() {
    return openBox()
        .values
        .where((element) => element.movieFromGenere == true)
        .toList();
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    return openBox()
        .values
        .where((element) => element.nowPlaying == true)
        .toList();
  }

  @override
  List<MovieVO> getPopularMovies() {
    return openBox()
        .values
        .where((element) => element.popularMovie == true)
        .toList();
  }

  @override
  List<MovieVO> getShowCaseMovie() {
    return openBox()
        .values
        .where((element) => element.showCaseMovie == true)
        .toList();
  }

  @override
  MovieVO? getMovieDetailById({required String movieId}) {
    return openBox().get(int.tryParse(movieId));
  }

  ///DELETING
  @override
  Future<void> deleteMovieByGenere() async {
    final List<int?> keys = openBox()
        .values
        .where((element) => element.movieFromGenere == true)
        .map((e) => e.id)
        .toList();
    await openBox().deleteAll(keys);
  }
}
