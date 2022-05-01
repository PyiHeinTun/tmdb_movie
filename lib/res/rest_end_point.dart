const String baseUrl = 'https://api.themoviedb.org/3';
// ignore: constant_identifier_names
const String api_key = 'api_key=f94e4d7c77f2fe73471cd5c8808380aa';

class EndPoint {
  static String popularPersonEndPoint() {
    return '$baseUrl/person/popular?$api_key';
  }

  static String getActorsCrewsEndPoint({required String movieId}) =>
      '$baseUrl/movie/$movieId/credits?$api_key';

  static String getNowPlayingEndPoint() =>
      '$baseUrl/movie/now_playing?$api_key';

  static String getPopularMovieEndPoint() => '$baseUrl/movie/popular?$api_key';

  static String getMoviesByGenereEndPoint({required int genereId}) =>
      '$baseUrl/discover/movie?$api_key&with_genres=$genereId';

  static String getShowCaseMoviesEndPoint() =>
      '$baseUrl/movie/top_rated?$api_key';

  static String getMovieDetailByIdEndPoint({required String movieId}) =>
      '$baseUrl/movie/$movieId?$api_key';

  static String getAllGenereEndPoint() => '$baseUrl/genre/movie/list?$api_key';
}
