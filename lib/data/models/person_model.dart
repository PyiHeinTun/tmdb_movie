import '../../domain/entity/person.dart';

class PersonModel extends Person {
  const PersonModel({
    required int id,
    required String profilePath,
    required String name,
    required double popularity,
  }) : super(
          id: id,
          name: name,
          profilePath: profilePath,
          popularity: popularity,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'] ?? 0,
      profilePath: json['profile_path'] ?? '',
      name: json['name'] ?? '',
      popularity: json['popularity'] as double? ?? 0,
    );
  }
}
