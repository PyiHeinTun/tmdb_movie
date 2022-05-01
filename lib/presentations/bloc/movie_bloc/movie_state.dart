part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieLoading extends MovieState {}

class GetNowPlayingMoviesLoading extends MovieState {}

class GetNowPlayingMoviesLoaded extends MovieState {
  final List<Movie> movieList;
  const GetNowPlayingMoviesLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}

class GetNowPlayingMoviesError extends MovieState {}

class GetPopularMoviesLoading extends MovieState {}

class GetPopularMoviesLoaded extends MovieState {
  final List<Movie> movieList;
  const GetPopularMoviesLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}

class GetPopularMoviesError extends MovieState {}

class GetMoviesByGenereLoading extends MovieState {}

class GetMoviesByGenereLoaded extends MovieState {
  final List<Movie> movieList;
  const GetMoviesByGenereLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}

class GetMoviesByGenereError extends MovieState {}

class GetShowCaseMoviesLoading extends MovieState {}

class GetShowCaseMoviesLoaded extends MovieState {
  final List<Movie> movieList;
  const GetShowCaseMoviesLoaded({required this.movieList});

  @override
  List<Object> get props => [movieList];
}

class GetShowCaseMoviesError extends MovieState {}

class GetMovieDetailByIdLoading extends MovieState {}

class GetMovieDetailByIdLoaded extends MovieState {
  final Movie movie;
  const GetMovieDetailByIdLoaded({required this.movie});

  @override
  List<Object> get props => [movie];
}

class GetMovieDetailByIdError extends MovieState {}
