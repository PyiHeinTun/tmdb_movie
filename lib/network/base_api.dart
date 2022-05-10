import '../datas/vos/movie_vo.dart';
import 'response/actors_crews_response.dart';
import 'response/genere_response.dart';
import 'response/movie_response.dart';
import 'response/popular_person_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'end_point_constant.dart';

part 'base_api.g.dart';

@RestApi(baseUrl: kMainUrl)
abstract class BaseApi {
  factory BaseApi(Dio dio, {String baseUrl}) = _BaseApi;

  //HOME ENDPOINT
  @GET(kPopularPersonEndPoint)
  Future<PopularPersonResponse> getPopularPerson();

  @GET(kGetNowPlayingEndPoint)
  Future<MovieResponse> getNowPlaying();

  @GET(kGetPopularMovieEndPoint)
  Future<MovieResponse> getPopularMovie();

  @GET(kGetMoviesByGenereEndPoint)
  Future<MovieResponse> getMoviesByGenere({
    @Query(kParameterWithGenere) int? genereId,
  });

  @GET(kGetShowCaseMoviesEndPoint)
  Future<MovieResponse> getShowCaseMovies();

  @GET(kGetAllGenereEndPoint)
  Future<GenereResponse> getAllGenere();

  //MOVIE DETAIL ENDPOINT
  @GET(kGetMovieDetailByIdEndPoint)
  Future<MovieVO> getMovieDetailById({
    @Path() String? movieId,
  });

  @GET(kGetActorsCrewsEndPoint)
  Future<ActorsCrewsResponse> getActorsCrews({
    @Path() String? movieId,
  });
}
