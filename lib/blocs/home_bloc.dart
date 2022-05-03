import 'package:flutter/foundation.dart';
import 'package:flutter_tmdb_movie/data/reposistory/genere_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/reposistory/movie_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/reposistory/person_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/sources/genere_remote_source.dart';
import 'package:flutter_tmdb_movie/data/sources/movie_remote_source.dart';
import 'package:flutter_tmdb_movie/data/sources/person_remote_source.dart';
import 'package:flutter_tmdb_movie/domain/entity/genere.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/domain/entity/person.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/genere_repository.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/movie_repository.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/person_repository.dart';

class HomeBloc extends ChangeNotifier {
  ///States
  List<Movie>? nowPlayingMovies;
  List<Movie>? popularMovies;
  List<Genere>? genereList;
  List<Movie>? moviesByGenere;
  List<Movie>? showCaseMovies;
  List<Person>? popularActors;

  bool? errorFlag;
  String? errorMessage;

  ///Repository Dependency
  MovieRepository movieRepository =
      MovieRepositoryImpl(dataSource: MovieRemoteSourceImpl());

  PersonReposistory personReposistory =
      PersonRepositoryImpl(dataSource: PersonRemoteSourceImpl());

  GenereRepository genereRepository =
      GenereReposistoryImpl(dataSource: GenereRemoteSourceImpl());

  ///Constructor Method
  HomeBloc() {
    _getAllEndpointInstantAndSet();
  }

  ///GET MOVIES BY TAPPING GENERE
  getMoviesByTapping({required int genereId}) async {
    moviesByGenere = null;
    notifyListeners();
    final movieByGenereData = await movieRepository.getMoviesByGenere(
        genereId: genereList![genereId].id);
    movieByGenereData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        moviesByGenere = r;
        notifyListeners();
      },
    );
  }

  ///GET ALL ENDPOINT INSTANT
  _getAllEndpointInstantAndSet() async {
    ///       NOW PLAYING MOVIES
    final getNowPlayingMoviesData = await movieRepository.getNowPlayingMovies();
    getNowPlayingMoviesData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        nowPlayingMovies = r;
        notifyListeners();
      },
    );

    ///       POPULAR MOVIES
    final popularMoviesData = await movieRepository.getPopularMovies();
    popularMoviesData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        popularMovies = r;
        notifyListeners();
      },
    );

    ///        GENERE LIST
    final genereListData = await genereRepository.getAllGenere();
    genereListData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        genereList = r;
        notifyListeners();
      },
    );

    ///       MOVIES BY GENERE
    final moviesByGenereData =
        await movieRepository.getMoviesByGenere(genereId: genereList!.first.id);
    moviesByGenereData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        moviesByGenere = r;
        notifyListeners();
      },
    );

    ///       SHOWCASE MOVIES
    final showCaseMovieData = await movieRepository.getShowCaseMovies();
    showCaseMovieData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        showCaseMovies = r;
        notifyListeners();
      },
    );

    ///      POPULAR ACTORS
    final popularActorsData = await personReposistory.getPopularActors();
    popularActorsData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        popularActors = r.personList;
        notifyListeners();
      },
    );
  }
}
