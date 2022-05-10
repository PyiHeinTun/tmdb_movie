import '../../datas/vos/person_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'actors_crews_response.g.dart';

@JsonSerializable()
class ActorsCrewsResponse {
  @JsonKey(name: 'cast')
  final List<PersonVO>? actors;
  @JsonKey(name: 'crew')
  final List<PersonVO>? crews;

  ActorsCrewsResponse({this.actors, this.crews});

  factory ActorsCrewsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActorsCrewsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ActorsCrewsResponseToJson(this);
}
