import 'movie_model.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_response.dart';

class MovieResponseModel extends MovieResponse {
  const MovieResponseModel({required List<Movie> movieList})
      : super(movieList: movieList);

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) {
    return MovieResponseModel(
      movieList:
          List<Movie>.from(json['results'].map((e) => MovieModel.fromJson(e)))
              .toList(),
    );
  }
}
