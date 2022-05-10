import 'app_models.dart';
import '../vos/person_vo.dart';
import '../vos/movie_vo.dart';
import '../vos/genere_vo.dart';
import '../../persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../network/data_agent/api_data_agent.dart';
import '../../network/data_agent/api_data_agent_impl.dart';
import '../../persistence/daos/genere_daos.dart';
import '../../persistence/daos/impl/genere_daos_impl.dart';
import '../../persistence/daos/impl/movie_daos_impl.dart';
import '../../persistence/daos/impl/person_daos_impl.dart';
import '../../persistence/daos/movie_daos.dart';
import '../../persistence/daos/person_daos.dart';

class AppModelsImpl implements AppModels {
  static final AppModelsImpl _singleton = AppModelsImpl._internal();
  //DEPENDENCY
  late ApiDataAgent _networkApi;
  late GenereDaos _genereDaos;
  late MovieDaos _movieDaos;
  late PersonDaos _personDaos;

  factory AppModelsImpl() {
    return _singleton;
  }

  AppModelsImpl._internal() {
    _genereDaos = GenereDaosImpl();
    _movieDaos = MovieDaosImpl();
    _personDaos = PersonDaosImpl();
    _networkApi = ApiDataAgentImpl();
  }

  ///NETWORK
  @override
  Future<List<PersonVO>?>? getActors({String? movieId}) {
    return _networkApi.getActors(movieId: movieId);
  }

  @override
  Future<List<GenereVO>?>? getAllGenere() {
    return _networkApi.getAllGenere();
  }

  @override
  Future<List<PersonVO>?>? getCrews({String? movieId}) {
    return _networkApi.getCrews(movieId: movieId);
  }

  @override
  Future<MovieVO?>? getMovieDetailById({required String movieId}) {
    return _networkApi.getMovieDetailById(movieId: movieId)?.then((value) {
      final existingMovie = Hive.box<MovieVO>(kHiveBoxMovie)
          .values
          .firstWhere((element) => element.id == int.parse(movieId));
      value?.movieFromGenere = existingMovie.movieFromGenere;
      value?.nowPlaying = existingMovie.nowPlaying;
      value?.popularMovie = existingMovie.popularMovie;
      value?.showCaseMovie = existingMovie.showCaseMovie;
      _movieDaos.writeMovieDaos(movieList: [value]);
      return value;
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  @override
  Future<List<MovieVO>?>? getMoviesByGenere({int? genereId}) async {
    _networkApi.getMoviesByGenere(genereId: genereId)?.then((value) {
      _movieDaos.deleteMovieByGenere();
      _movieDaos.writeMovieDaos(
          movieList: value!.map((e) {
        e.movieFromGenere = true;
        return e;
      }).toList());
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  @override
  Future<List<MovieVO>?>? getNowPlaying() {
    _networkApi.getNowPlaying()?.then((value) {
      _movieDaos.writeMovieDaos(
          movieList: value?.map((e) {
                e.nowPlaying = true;
                e.popularMovie = true;
                e.showCaseMovie = true;
                return e;
              }).toList() ??
              []);
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  @override
  Future<List<MovieVO>?>? getPopularMovie() {
    _networkApi.getPopularMovie()?.then((value) {
      _movieDaos.writeMovieDaos(
          movieList: value!.map((e) {
        e.popularMovie = true;
        return e;
      }).toList());
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  @override
  Future<List<PersonVO>?>? getPopularPerson() {
    return _networkApi.getPopularPerson();
  }

  @override
  Future<List<MovieVO>?>? getShowCaseMovies() {
    _networkApi.getPopularMovie()?.then((value) {
      _movieDaos.writeMovieDaos(
          movieList: value!.map((e) {
        e.showCaseMovie = true;
        return e;
      }).toList());
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  ////========== DATABASE ==============
  ///===========NORMAL DATABASE ==========

  @override
  Future<List<PersonVO>> getActorsFromDatabase(
      {required String? movieId}) async {
    await getActors(movieId: movieId)
        ?.then((value) => _personDaos.writePersonDaos(personList: value))
        .onError((error, stackTrace) => throw Exception(error));
    return Future.value(_personDaos.getPopularPerson());
  }

  @override
  Future<List<GenereVO>?>? getAllGenereFromDatabase() async {
    await getAllGenere()
        ?.then((value) => _genereDaos.writeAllGenereDaos(genereList: value!))
        .onError((error, stackTrace) => throw Exception(error));

    return Future.value(_genereDaos.readAllGenereDaos());
  }

  @override
  Future<List<PersonVO>> getCrewsFromDatabase(
      {required String? movieId}) async {
    await getCrews(movieId: movieId)
        ?.then((value) => _personDaos.writePersonDaos(personList: value))
        .onError((error, stackTrace) => throw Exception(error));
    return Future.value(_personDaos.getCrews());
  }

  @override
  Future<List<PersonVO>>? getPopularPersonFromDatabase() {
    return getPopularPerson()?.then((list) {
      _personDaos.writePersonDaos(
          personList: list?.map((e) {
        e.popularActors = true;
        return e;
      }).toList());
      return Future.value(_personDaos.getPopularPerson());
    }).onError((error, stackTrace) {
      throw Exception(error);
    });
  }

  //////REACTIVE PROGRAMMING

  @override
  Stream<MovieVO?> getMovieDetailByIdFromDatabase({required String movieId}) {
    getMovieDetailById(movieId: movieId);
    return _movieDaos
        .getAllMovieStream()
        .startWithStream(_movieDaos.getMovieDetailByIdStream(movieId: movieId))
        .map((event) => _movieDaos.getMovieDetailById(movieId: movieId));
  }

  @override
  Stream<List<MovieVO>> getMoviesByGenereFromDatabase({required int genereId}) {
    getMoviesByGenere(genereId: genereId);
    return _movieDaos
        .getAllMovieStream()
        .startWithStream(_movieDaos.getMovieByGenereStream())
        .map((event) => _movieDaos.getMovieByGenere());
  }

  @override
  Stream<List<MovieVO>> getNowPlayingFromDatabase() {
    getNowPlaying();
    return _movieDaos
        .getAllMovieStream()
        .startWithStream(_movieDaos.getNowPlayingMoviesStream())
        .map((event) => _movieDaos.getNowPlayingMovies());
  }

  @override
  Stream<List<MovieVO>> getPopularMovieFromDatabase() {
    getPopularMovie();
    return _movieDaos
        .getAllMovieStream()
        .startWithStream(_movieDaos.getPopularMoviesStream())
        .map((event) => _movieDaos.getPopularMovies());
  }

  @override
  Stream<List<MovieVO>> getShowCaseMoviesFromDatabase() {
    getShowCaseMovies();
    return _movieDaos
        .getAllMovieStream()
        .startWithStream(_movieDaos.getShowCaseMovieStream())
        .map((event) => _movieDaos.getShowCaseMovie());
  }
}
