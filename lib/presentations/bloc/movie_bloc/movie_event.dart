part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingMovies extends MovieEvent {}

class GetPopularMovies extends MovieEvent {}

class GetMoviesByGenere extends MovieEvent {
  final int genereId;
  const GetMoviesByGenere({required this.genereId});

  @override
  List<Object> get props => [genereId];
}

class GetShowCaseMovies extends MovieEvent {}

class GetMovieDetailById extends MovieEvent {
  final String movieId;
  const GetMovieDetailById({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
