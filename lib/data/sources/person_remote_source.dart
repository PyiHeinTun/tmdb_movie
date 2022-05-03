import 'package:dio/dio.dart';
import '../models/actors_crews_response_model.dart';
import '../models/popular_person_response_model.dart';
import '../../domain/entity/actors_crews_response.dart';
import '../../domain/entity/popular_person_response.dart';
import '../../res/rest_end_point.dart';

abstract class PersonRemoteSource {
  Future<PopularPersonResponse> getPopularPerson();
  Future<ActorsCrewsResponse> getActorsCrews({required String movieId});
}

class PersonRemoteSourceImpl implements PersonRemoteSource {
  @override
  Future<ActorsCrewsResponse> getActorsCrews({required String movieId}) async {
    try {
      var response =
          await Dio().get(EndPoint.getActorsCrewsEndPoint(movieId: movieId));
      return ActorsCrewsResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<PopularPersonResponse> getPopularPerson() async {
    try {
      var response = await Dio().get(EndPoint.popularPersonEndPoint());
      return PopularPersonResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
