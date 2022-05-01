import 'package:equatable/equatable.dart';

import 'movie.dart';

class MovieResponse extends Equatable {
  final List<Movie> movieList;
  const MovieResponse({required this.movieList});

  @override
  List<Object?> get props => [movieList];
}
