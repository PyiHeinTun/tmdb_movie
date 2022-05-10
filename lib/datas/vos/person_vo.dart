import '../../network/end_point_constant.dart';
import '../../persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeIdPerson, adapterName: 'PersonVoAdapter')
class PersonVO {
  @JsonKey(name: 'id')
  @HiveField(1)
  final int? id;
  @JsonKey(name: 'profile_path', fromJson: _profileFromJson)
  @HiveField(2)
  final String? profilePath;
  @JsonKey(name: 'name')
  @HiveField(3)
  final String? name;
  @JsonKey(name: 'popularity')
  @HiveField(4)
  final double? popularity;

  //FOR HIVE
  bool? popularActors;
  bool? cast;
  bool? crew;

  PersonVO({
    required this.id,
    required this.profilePath,
    required this.name,
    required this.popularity,
    this.cast,
    this.crew,
    this.popularActors,
  });

  @override
  bool operator ==(Object other) =>
      identical(other, this) || other is PersonVO && other.id == id;

  @override
  int get hashCode => id.hashCode;

  factory PersonVO.fromJson(Map<String, dynamic> json) =>
      _$PersonVOFromJson(json);
  Map<String, dynamic> toJson() => _$PersonVOToJson(this);
}

String _profileFromJson(String json) => '$kImageUrl$json';
