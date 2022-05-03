import 'package:dartz/dartz.dart';
import 'package:flutter_tmdb_movie/core/error/Failure.dart';
import 'package:flutter_tmdb_movie/data/sources/genere_remote_source.dart';
import 'package:flutter_tmdb_movie/domain/entity/genere.dart';
import 'package:flutter_tmdb_movie/domain/reposistory/genere_repository.dart';

class GenereReposistoryImpl implements GenereRepository {
  final GenereRemoteSource dataSource;
  const GenereReposistoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<Genere>>> getAllGenere() async {
    //If network is unstable Get Data From Cache

    //Get Data From Api
    try {
      final List<Genere> data = await dataSource.getAllGenere();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
