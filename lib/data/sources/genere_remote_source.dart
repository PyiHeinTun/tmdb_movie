import 'package:dio/dio.dart';
import '../models/genere_response_model.dart';
import '../../domain/entity/genere.dart';
import '../../res/rest_end_point.dart';

abstract class GenereRemoteSource {
  Future<List<Genere>> getAllGenere();
}

class GenereRemoteSourceImpl implements GenereRemoteSource {
  @override
  Future<List<Genere>> getAllGenere() async {
    try {
      var response = await Dio().get(EndPoint.getAllGenereEndPoint());
      return GenereResponseModel.fromJson(response.data).genereList;
    } catch (e) {
      throw Exception(e);
    }
  }
}
