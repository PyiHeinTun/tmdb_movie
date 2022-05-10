import '../../datas/vos/genere_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genere_response.g.dart';

@JsonSerializable()
class GenereResponse {
  @JsonKey(name: 'genres')
  final List<GenereVO>? genereList;

  GenereResponse({this.genereList});

  factory GenereResponse.fromJson(Map<String, dynamic> json) =>
      _$GenereResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenereResponseToJson(this);
}
