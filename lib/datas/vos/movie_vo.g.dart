// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieVoAdapter extends TypeAdapter<MovieVO> {
  @override
  final int typeId = 2;

  @override
  MovieVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieVO(
      id: fields[1] as int?,
      title: fields[2] as String?,
      popularity: fields[3] as double?,
      overview: fields[4] as String?,
      backdropPath: fields[5] as String?,
      releaseDate: fields[6] as String?,
      voteCount: fields[7] as int?,
      voteAverage: fields[8] as double?,
      runTime: fields[10] as int?,
      generes: (fields[11] as List?)?.cast<GenereVO>(),
      originalTitle: fields[12] as String?,
      productionCountries: (fields[13] as List?)?.cast<ProductionCountryVO>(),
      movieFromGenere: fields[16] as bool?,
      nowPlaying: fields[14] as bool?,
      popularMovie: fields[15] as bool?,
      showCaseMovie: fields[17] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, MovieVO obj) {
    writer
      ..writeByte(16)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.popularity)
      ..writeByte(4)
      ..write(obj.overview)
      ..writeByte(5)
      ..write(obj.backdropPath)
      ..writeByte(6)
      ..write(obj.releaseDate)
      ..writeByte(7)
      ..write(obj.voteCount)
      ..writeByte(8)
      ..write(obj.voteAverage)
      ..writeByte(10)
      ..write(obj.runTime)
      ..writeByte(11)
      ..write(obj.generes)
      ..writeByte(12)
      ..write(obj.originalTitle)
      ..writeByte(13)
      ..write(obj.productionCountries)
      ..writeByte(14)
      ..write(obj.nowPlaying)
      ..writeByte(15)
      ..write(obj.popularMovie)
      ..writeByte(16)
      ..write(obj.movieFromGenere)
      ..writeByte(17)
      ..write(obj.showCaseMovie);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVO _$MovieVOFromJson(Map<String, dynamic> json) => MovieVO(
      id: json['id'] as int?,
      title: json['title'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      backdropPath: _backdropFromJson(json['backdrop_path'] as String),
      releaseDate: json['release_date'] as String?,
      voteCount: json['vote_count'] as int?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      runTime: json['runtime'] as int?,
      generes: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenereVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      originalTitle: json['original_title'] as String?,
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      movieFromGenere: json['movieFromGenere'] as bool?,
      nowPlaying: json['nowPlaying'] as bool?,
      popularMovie: json['popularMovie'] as bool?,
      showCaseMovie: json['showCaseMovie'] as bool?,
    );

Map<String, dynamic> _$MovieVOToJson(MovieVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'popularity': instance.popularity,
      'overview': instance.overview,
      'backdrop_path': instance.backdropPath,
      'release_date': instance.releaseDate,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'runtime': instance.runTime,
      'genres': instance.generes,
      'original_title': instance.originalTitle,
      'production_countries': instance.productionCountries,
      'nowPlaying': instance.nowPlaying,
      'popularMovie': instance.popularMovie,
      'movieFromGenere': instance.movieFromGenere,
      'showCaseMovie': instance.showCaseMovie,
    };
