part of 'genere_bloc.dart';

abstract class GenereState extends Equatable {
  const GenereState();

  @override
  List<Object> get props => [];
}

class GenereLoading extends GenereState {}

class GenereLoaded extends GenereState {
  final List<Genere> genereList;
  const GenereLoaded({required this.genereList});

  @override
  List<Object> get props => [genereList];
}

class GenereError extends GenereState {}
