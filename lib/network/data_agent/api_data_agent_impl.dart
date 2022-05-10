import 'package:dio/dio.dart';
import '../../datas/vos/person_vo.dart';
import '../../datas/vos/movie_vo.dart';
import '../../datas/vos/genere_vo.dart';
import '../base_api.dart';
import 'api_data_agent.dart';
import '../end_point_constant.dart';

class ApiDataAgentImpl implements ApiDataAgent {
  BaseApi? _api;

  static final ApiDataAgentImpl _singleton = ApiDataAgentImpl._internal();

  factory ApiDataAgentImpl() {
    return _singleton;
  }

  ApiDataAgentImpl._internal() {
    final Dio? _dio = Dio();
    _dio?.options.queryParameters = {
      kApiKeyName: kApikey,
    };
    _api = BaseApi(_dio ?? Dio());
  }

  @override
  Future<List<PersonVO>?>? getActors({String? movieId}) async {
    return _api
        ?.getActorsCrews(movieId: movieId)
        .asStream()
        .map((response) => response.actors)
        .first;
  }

  @override
  Future<List<PersonVO>?>? getCrews({String? movieId}) async {
    return _api
        ?.getActorsCrews(movieId: movieId)
        .asStream()
        .map((response) => response.crews)
        .first;
  }

  @override
  Future<List<GenereVO>?>? getAllGenere() async {
    return _api
        ?.getAllGenere()
        .asStream()
        .map((response) => response.genereList)
        .first;
  }

  @override
  Future<MovieVO?>? getMovieDetailById({required String movieId}) async {
    return _api?.getMovieDetailById(movieId: movieId).asStream().first;
  }

  @override
  Future<List<MovieVO>?>? getMoviesByGenere({int? genereId}) async {
    return _api
        ?.getMoviesByGenere(genereId: genereId)
        .asStream()
        .map((response) => response.movieList)
        .first;
  }

  @override
  Future<List<MovieVO>?>? getNowPlaying() async {
    return _api
        ?.getNowPlaying()
        .asStream()
        .map((response) => response.movieList)
        .first;
  }

  @override
  Future<List<MovieVO>?>? getPopularMovie() async {
    return _api
        ?.getPopularMovie()
        .asStream()
        .map((response) => response.movieList)
        .first;
  }

  @override
  Future<List<PersonVO>?>? getPopularPerson() async {
    return _api
        ?.getPopularPerson()
        .asStream()
        .map((response) => response.personList)
        .first;
  }

  @override
  Future<List<MovieVO>?>? getShowCaseMovies() async {
    return _api
        ?.getShowCaseMovies()
        .asStream()
        .map((response) => response.movieList)
        .first;
  }
}
