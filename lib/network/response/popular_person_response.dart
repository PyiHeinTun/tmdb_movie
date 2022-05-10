import '../../datas/vos/person_vo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'popular_person_response.g.dart';

@JsonSerializable()
class PopularPersonResponse {
  @JsonKey(name: 'results')
  final List<PersonVO>? personList;

  PopularPersonResponse({this.personList});

  factory PopularPersonResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularPersonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PopularPersonResponseToJson(this);
}
