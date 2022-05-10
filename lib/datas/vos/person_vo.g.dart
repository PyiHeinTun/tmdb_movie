// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonVoAdapter extends TypeAdapter<PersonVO> {
  @override
  final int typeId = 3;

  @override
  PersonVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonVO(
      id: fields[1] as int?,
      profilePath: fields[2] as String?,
      name: fields[3] as String?,
      popularity: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, PersonVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.profilePath)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.popularity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonVO _$PersonVOFromJson(Map<String, dynamic> json) => PersonVO(
      id: json['id'] as int?,
      profilePath: _profileFromJson(json['profile_path'] as String),
      name: json['name'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      cast: json['cast'] as bool?,
      crew: json['crew'] as bool?,
      popularActors: json['popularActors'] as bool?,
    );

Map<String, dynamic> _$PersonVOToJson(PersonVO instance) => <String, dynamic>{
      'id': instance.id,
      'profile_path': instance.profilePath,
      'name': instance.name,
      'popularity': instance.popularity,
      'popularActors': instance.popularActors,
      'cast': instance.cast,
      'crew': instance.crew,
    };
