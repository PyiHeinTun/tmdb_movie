import 'package:equatable/equatable.dart';
import 'genere.dart';

// ignore: must_be_immutable
class Movie extends Equatable {
  final int id;
  final String title;
  final double popularity;
  final String overview;
  final String backdropPath;
  final String releaseDate;
  final int voteCount;
  final double voteAverage;

  //List of Detail of Movie
  int runTime;
  List<Genere> generes;
  String originalTitle;
  List<Genere> types;
  String productionCountries;

  Movie({
    required this.id,
    required this.title,
    required this.popularity,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteCount,
    required this.voteAverage,
    //List of Detail of Movie
    this.runTime = 0,
    this.generes = const [],
    this.originalTitle = '',
    this.types = const [],
    this.productionCountries = '',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        popularity,
        overview,
        backdropPath,
        releaseDate,
        voteAverage,
        voteCount,
        //List of Detail of Movie
        runTime,
        generes,
        originalTitle,
        types,
        productionCountries,
      ];
}
