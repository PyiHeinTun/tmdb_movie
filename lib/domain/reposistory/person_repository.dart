import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entity/actors_crews_response.dart';
import '../entity/popular_person_response.dart';

abstract class PersonReposistory {
  Future<Either<Failure, PopularPersonResponse>> getPopularActors();

  Future<Either<Failure, ActorsCrewsResponse>> getActorsCrews(
      {required String movieId});
}
