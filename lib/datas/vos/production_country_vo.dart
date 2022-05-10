import '../../persistence/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'production_country_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: kHiveTypeIdProductionCountry,
    adapterName: 'ProductionCountryVoAdapter')
class ProductionCountryVO {
  @JsonKey(name: 'iso_3166_1')
  @HiveField(1)
  final String? iso31661;
  @JsonKey(name: 'name')
  @HiveField(2)
  final String? name;

  ProductionCountryVO({this.iso31661, this.name});

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      other is ProductionCountryVO && other.name == name;

  @override
  int get hashCode => name.hashCode;

  factory ProductionCountryVO.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountryVOFromJson(json);
  Map<String, dynamic> toJson() => _$ProductionCountryVOToJson(this);
}
