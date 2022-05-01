import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb_movie/domain/entity/actors_crews_response.dart';
import 'package:flutter_tmdb_movie/domain/entity/popular_person_response.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/person_repository.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonReposistory reposistory;

  PersonBloc({required this.reposistory}) : super(PersonInitial()) {
    on<GetPopularActors>((event, emit) async {
      emit(GetPopularActorsLoading());
      final data = await reposistory.getPopularActors();
      data.fold(
        (l) => emit(GetPopularActorsError()),
        (r) => emit(GetPopularActorsLoaded(personList: r)),
      );
    });

    on<GetActorsAndCrews>((event, emit) async {
      emit(GetActorsAndCrewsLoading());
      final data = await reposistory.getActorsCrews(movieId: event.movieId);
      data.fold(
        (l) => emit(GetActorsAndCrewsError()),
        (r) => emit(GetActorsAndCrewsLoaded(actorsCrews: r)),
      );
    });
  }
}
