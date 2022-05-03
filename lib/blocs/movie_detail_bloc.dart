import 'package:flutter/cupertino.dart';
import 'package:flutter_tmdb_movie/data/reposistory/movie_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/reposistory/person_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/sources/movie_remote_source.dart';
import 'package:flutter_tmdb_movie/data/sources/person_remote_source.dart';
import 'package:flutter_tmdb_movie/domain/entity/movie.dart';
import 'package:flutter_tmdb_movie/domain/entity/person.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/movie_repository.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/person_repository.dart';

class MovieDetailBloc extends ChangeNotifier {
  ///MovieID for Detail
  final String movieId;

  ///States
  Movie? movieDetail;
  List<Person>? actors;
  List<Person>? crews;

  bool? errorFlag;
  String? errorMessage;

  ///Repository Dependency
  MovieRepository movieRepository =
      MovieRepositoryImpl(dataSource: MovieRemoteSourceImpl());

  PersonReposistory personReposistory =
      PersonRepositoryImpl(dataSource: PersonRemoteSourceImpl());

  ///Constructor Method
  MovieDetailBloc({required this.movieId}) {
    getAllEndPointInstantAndSet();
  }

  ///GET ALL ENDPOINT INSTANT
  getAllEndPointInstantAndSet() async {
    /// MOVIE DETAIL BY ID
    final movieDetailData =
        await movieRepository.getMovieDetailById(movieId: movieId);
    movieDetailData.fold((l) {
      errorFlag = true;
      errorMessage = l.message;
      notifyListeners();
    }, (r) {
      movieDetail = r;
      notifyListeners();
    });

    /// GET ACTORS AND CREWS
    final actorsAndCrewsData =
        await personReposistory.getActorsCrews(movieId: movieId);
    actorsAndCrewsData.fold(
      (l) {
        errorFlag = true;
        errorMessage = l.message;
        notifyListeners();
      },
      (r) {
        actors = r.actors;
        crews = r.crews;
        notifyListeners();
      },
    );
  }
}
