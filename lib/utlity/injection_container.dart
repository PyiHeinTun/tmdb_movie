import 'package:flutter_tmdb_movie/data/reposistory/genere_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/reposistory/movie_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/reposistory/person_repository_impl.dart';
import 'package:flutter_tmdb_movie/data/sources/genere_remote_source.dart';
import 'package:flutter_tmdb_movie/data/sources/movie_remote_source.dart';
import 'package:flutter_tmdb_movie/data/sources/person_remote_source.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/genere_repository.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/movie_repository.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/person_repository.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/genere_bloc/genere_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter_tmdb_movie/presentations/bloc/person_bloc/person_bloc.dart';
import 'package:get_it/get_it.dart';

class InjectionContainer {
  static final GetIt sl = GetIt.instance;
  static Future<void> init() async {
    //BLOC
    sl.registerFactory<MovieBloc>(() => MovieBloc(repository: sl()));
    sl.registerFactory<GenereBloc>(() => GenereBloc(repository: sl()));
    sl.registerFactory<PersonBloc>(() => PersonBloc(reposistory: sl()));
    //Reposistory
    sl.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(dataSource: sl()));
    sl.registerLazySingleton<GenereRepository>(
        () => GenereReposistoryImpl(dataSource: sl()));
    sl.registerLazySingleton<PersonReposistory>(
        () => PersonRepositoryImpl(dataSource: sl()));
    //Data
    sl.registerLazySingleton<MovieRemoteSource>(() => MovieRemoteSourceImpl());
    sl.registerLazySingleton<GenereRemoteSource>(
        () => GenereRemoteSourceImpl());
    sl.registerLazySingleton<PersonRemoteSource>(
        () => PersonRemoteSourceImpl());
    //Core

    //External
  }
}
