import 'genere_model.dart';
import '../../domain/entity/genere.dart';
import '../../domain/entity/genere_response.dart';

class GenereResponseModel extends GenereResponse {
  const GenereResponseModel({required List<Genere> genereList})
      : super(genereList: genereList);

  factory GenereResponseModel.fromJson(Map<String, dynamic> json) =>
      GenereResponseModel(
        genereList: List<Genere>.from(
            json['genres'].map((e) => GenereModel.fromJson(e))).toList(),
      );
}
