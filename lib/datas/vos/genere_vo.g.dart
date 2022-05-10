// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genere_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GenereVoAdapter extends TypeAdapter<GenereVO> {
  @override
  final int typeId = 1;

  @override
  GenereVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GenereVO(
      id: fields[1] as int?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GenereVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenereVoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenereVO _$GenereVOFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['id'],
  );
  return GenereVO(
    id: json['id'] as int?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$GenereVOToJson(GenereVO instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['name'] = instance.name;
  return val;
}
