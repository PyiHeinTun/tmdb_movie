import 'person_model.dart';
import '../../domain/entity/person.dart';
import '../../domain/entity/popular_person_response.dart';

class PopularPersonResponseModel extends PopularPersonResponse {
  const PopularPersonResponseModel({required List<Person> personList})
      : super(personList: personList);

  factory PopularPersonResponseModel.fromJson(Map<String, dynamic> json) {
    return PopularPersonResponseModel(
      personList:
          List<Person>.from(json['results'].map((e) => PersonModel.fromJson(e)))
              .toList(),
    );
  }
}
