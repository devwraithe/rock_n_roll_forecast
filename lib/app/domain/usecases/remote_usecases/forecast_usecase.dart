import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';
import '../../repositories/remote_repository.dart';

abstract class ForecastUsecase {
  Future<Either<Failure, List<ForecastEntity>>> execute(
    String lat,
    String lon,
  );
}

class ForecastUsecaseImpl implements ForecastUsecase {
  final ForecastRemoteRepository _repo;
  ForecastUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, List<ForecastEntity>>> execute(
    String lat,
    String lon,
  ) async {
    final result = await _repo.getForecast(lat, lon);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
