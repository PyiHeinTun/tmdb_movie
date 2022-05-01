import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tmdb_movie/domain/entity/genere.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/genere_repository.dart';

part 'genere_event.dart';
part 'genere_state.dart';

class GenereBloc extends Bloc<GetGenereEvent, GenereState> {
  final GenereRepository repository;

  GenereBloc({required this.repository}) : super(GenereLoading()) {
    on<GetAllGenere>((event, emit) async {
      emit(GenereLoading());
      final data = await repository.getAllGenere();
      data.fold(
        (l) => emit(GenereError()),
        (r) => emit(GenereLoaded(genereList: r)),
      );
    });
  }
}
