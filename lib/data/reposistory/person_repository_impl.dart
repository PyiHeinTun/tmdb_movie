import '../../core/error/exception.dart';
import '../sources/person_remote_source.dart';
import '../../domain/entity/actors_crews_response.dart';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entity/popular_person_response.dart';
import '../../domain/reposistory/person_repository.dart';

class PersonRepositoryImpl implements PersonReposistory {
  final PersonRemoteSource dataSource;
  PersonRepositoryImpl({required this.dataSource});
  @override
  //Can Check Network Connection and return Failure Object
  Future<Either<Failure, ActorsCrewsResponse>> getActorsCrews(
      {required String movieId}) async {
    try {
      final ActorsCrewsResponse data =
          await dataSource.getActorsCrews(movieId: movieId);
      return Right(data);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  //Can Check Network Connection and return Failure Object
  Future<Either<Failure, PopularPersonResponse>> getPopularActors() async {
    try {
      final PopularPersonResponse data = await dataSource.getPopularPerson();
      return Right(data);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}
