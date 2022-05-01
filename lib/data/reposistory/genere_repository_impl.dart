import '../../core/error/exception.dart';
import '../sources/genere_remote_source.dart';
import '../../domain/entity/genere.dart';
import '../../core/error/Failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/reposistory/genere_repository.dart';

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
    } on ServerException catch (_) {
      return Left(ServerFailure());
    }
  }
}
