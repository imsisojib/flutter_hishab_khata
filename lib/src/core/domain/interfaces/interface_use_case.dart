import 'package:dartz/dartz.dart';
import 'package:flutter_hishab_khata/src/core/data/models/failure.dart';

abstract class IUseCase<TUseCaseInput, TUseCaseOutput> {
  Future<Either<Failure, TUseCaseOutput>> execute(TUseCaseInput input);
}
