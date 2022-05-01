import 'person_model.dart';
import '../../domain/entity/actors_crews_response.dart';
import '../../domain/entity/person.dart';

class ActorsCrewsResponseModel extends ActorsCrewsResponse {
  const ActorsCrewsResponseModel(
      {required List<Person> actors, required List<Person> crews})
      : super(
          actors: actors,
          crews: crews,
        );

  factory ActorsCrewsResponseModel.fromJson(Map<String, dynamic> json) =>
      ActorsCrewsResponseModel(
        actors:
            List<Person>.from(json['cast'].map((e) => PersonModel.fromJson(e))),
        crews:
            List<Person>.from(json['crew'].map((e) => PersonModel.fromJson(e))),
      );
}
