import 'genere_vo.dart';
import 'production_country_vo.dart';
import '../../network/end_point_constant.dart';
import '../../persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIdMovie, adapterName: 'MovieVoAdapter')
class MovieVO {
  @JsonKey(name: 'id')
  @HiveField(1)
  final int? id;
  @JsonKey(name: 'title')
  @HiveField(2)
  final String? title;
  @JsonKey(name: 'popularity')
  @HiveField(3)
  final double? popularity;
  @JsonKey(name: 'overview')
  @HiveField(4)
  final String? overview;
  @JsonKey(name: 'backdrop_path', fromJson: _backdropFromJson)
  @HiveField(5)
  final String? backdropPath;
  @JsonKey(name: 'release_date')
  @HiveField(6)
  final String? releaseDate;
  @JsonKey(name: 'vote_count')
  @HiveField(7)
  final int? voteCount;
  @JsonKey(name: 'vote_average')
  @HiveField(8)
  final double? voteAverage;

  //List of Detail of Movie
  @JsonKey(name: 'runtime', disallowNullValue: false)
  @HiveField(10)
  final int? runTime;
  @JsonKey(name: 'genres', disallowNullValue: false)
  @HiveField(11)
  final List<GenereVO>? generes;
  @JsonKey(name: 'original_title', disallowNullValue: false)
  @HiveField(12)
  final String? originalTitle;
  @JsonKey(name: 'production_countries', disallowNullValue: false)
  @HiveField(13)
  final List<ProductionCountryVO>? productionCountries;

  //FOR HIVE
  @HiveField(14)
  bool? nowPlaying;
  @HiveField(15)
  bool? popularMovie;
  @HiveField(16)
  bool? movieFromGenere;
  @HiveField(17)
  bool? showCaseMovie;

  MovieVO({
    required this.id,
    required this.title,
    required this.popularity,
    required this.overview,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteCount,
    required this.voteAverage,
    //List of Detail of Movie
    required this.runTime,
    required this.generes,
    required this.originalTitle,
    required this.productionCountries,

    //FOR HIVE
    this.movieFromGenere,
    this.nowPlaying,
    this.popularMovie,
    this.showCaseMovie,
  });

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is MovieVO && other.id == id && other.generes == generes;

  @override
  int get hashCode => id.hashCode;

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json);
  Map<String, dynamic> toJson() => _$MovieVOToJson(this);
}

String? _backdropFromJson(String json) => '$kImageUrl$json';
