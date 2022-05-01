import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/movie_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository repository;
  MovieBloc({required this.repository}) : super(MovieLoading()) {
    on<GetNowPlayingMovies>((event, emit) async {
      emit(GetNowPlayingMoviesLoading());
      final data = await repository.getNowPlayingMovies();
      data.fold(
        (l) => emit(GetNowPlayingMoviesError()),
        (r) => emit(GetNowPlayingMoviesLoaded(movieList: r)),
      );
    });

    on<GetPopularMovies>((event, emit) async {
      emit(GetPopularMoviesLoading());
      final data = await repository.getPopularMovies();
      data.fold(
        (l) => emit(GetPopularMoviesError()),
        (r) => emit(GetPopularMoviesLoaded(movieList: r)),
      );
    });

    on<GetMoviesByGenere>((event, emit) async {
      emit(GetMoviesByGenereLoading());
      final data = await repository.getMoviesByGenere(genereId: event.genereId);
      data.fold(
        (l) => emit(GetMoviesByGenereError()),
        (r) => emit(GetMoviesByGenereLoaded(movieList: r)),
      );
    });

    on<GetShowCaseMovies>((event, emit) async {
      emit(GetMoviesByGenereLoading());
      final data = await repository.getShowCaseMovies();
      data.fold(
        (l) => emit(GetShowCaseMoviesError()),
        (r) => emit(GetShowCaseMoviesLoaded(movieList: r)),
      );
    });

    on<GetMovieDetailById>((event, emit) async {
      emit(GetMovieDetailByIdLoading());
      final data = await repository.getMovieDetailById(movieId: event.movieId);
      data.fold(
        (l) => emit(GetMovieDetailByIdError()),
        (r) => emit(GetMovieDetailByIdLoaded(movie: r)),
      );
    });
  }
}
