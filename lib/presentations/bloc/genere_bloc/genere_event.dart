part of 'genere_bloc.dart';

abstract class GetGenereEvent extends Equatable {
  const GetGenereEvent();

  @override
  List<Object> get props => [];
}

class GetAllGenere extends GetGenereEvent {}
