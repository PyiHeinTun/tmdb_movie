import '../../persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genere_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIdGenere, adapterName: 'GenereVoAdapter')
class GenereVO {
  @JsonKey(name: 'id', disallowNullValue: true)
  @HiveField(1)
  final int? id;
  @JsonKey(name: 'name', disallowNullValue: false)
  @HiveField(2)
  final String? name;

  const GenereVO({
    required this.id,
    required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenereVO && other.id == id && other.name == name;

  @override
  int get hashCode => id.hashCode;

  factory GenereVO.fromJson(Map<String, dynamic> json) =>
      _$GenereVOFromJson(json);
  Map<String, dynamic> toJson() => _$GenereVOToJson(this);
}
