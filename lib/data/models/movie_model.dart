import 'genere_model.dart';
import '../../domain/entity/genere.dart';
import '../../domain/entity/movie.dart';

// ignore: must_be_immutable
class MovieModel extends Movie {
  MovieModel({
    required int id,
    required String title,
    required double popularity,
    required String overview,
    required String backdropPath,
    required String releaseDate,
    required int voteCount,
    required double voteAverage,

    //List of Detail of Movie
    int runTime = 0,
    List<Genere> generes = const [],
    String originalTitle = '',
    List<Genere> types = const [],
    String productionCountries = '',
  }) : super(
          id: id,
          title: title,
          popularity: popularity,
          overview: overview,
          backdropPath: backdropPath,
          releaseDate: releaseDate,
          voteCount: voteCount,
          voteAverage: voteAverage,

          // //List of Movie Detail
          runTime: runTime,
          generes: generes,
          originalTitle: originalTitle,
          types: types,
          productionCountries: productionCountries,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      popularity: double.parse(json['popularity'].toString()),
      overview: json['overview'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteCount: json['vote_count'] ?? 0,
      voteAverage: double.parse(json['vote_average'].toString()),
      //List of Movie Detail
      runTime: json['runtime'] ?? 0,
      generes: json['genres'] == null
          ? []
          : List<Genere>.from(
              json['genres'].map((e) => GenereModel.fromJson(e))),
      originalTitle: json['original_title'] ?? '',
      types: json['genres'] == null
          ? []
          : List<Genere>.from(
              json['genres'].map((e) => GenereModel.fromJson(e))),
      productionCountries: json['production_countries'] == null
          ? ''
          : json['production_countries'][0]['name'],
    );
  }
}
