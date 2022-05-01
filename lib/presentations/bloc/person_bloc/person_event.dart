part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();

  @override
  List<Object> get props => [];
}

class GetPopularActors extends PersonEvent {}

class GetActorsAndCrews extends PersonEvent {
  final String movieId;
  const GetActorsAndCrews({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
