import 'package:dartz/dartz.dart';
import '../../core/error/Failure.dart';
import '../entity/genere.dart';

abstract class GenereRepository {
  Future<Either<Failure, List<Genere>>> getAllGenere();
}
