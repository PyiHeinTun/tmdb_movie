part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

class PersonInitial extends PersonState {}

class GetPopularActorsLoading extends PersonState {}

class GetPopularActorsLoaded extends PersonState {
  final PopularPersonResponse personList;
  const GetPopularActorsLoaded({required this.personList});

  @override
  List<Object> get props => [personList];
}

class GetPopularActorsError extends PersonState {}

class GetActorsAndCrewsLoading extends PersonState {}

class GetActorsAndCrewsLoaded extends PersonState {
  final ActorsCrewsResponse actorsCrews;
  const GetActorsAndCrewsLoaded({required this.actorsCrews});
  @override
  List<Object> get props => [actorsCrews];
}

class GetActorsAndCrewsError extends PersonState {}
