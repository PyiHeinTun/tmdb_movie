import '../../domain/entity/genere.dart';

class GenereModel extends Genere {
  const GenereModel({
    required int id,
    required String name,
  }) : super(id: id, name: name);

  factory GenereModel.fromJson(Map<String, dynamic> json) {
    return GenereModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
