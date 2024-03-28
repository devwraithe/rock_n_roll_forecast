import 'package:dartz/dartz.dart';

import '../../../../../shared/errors/failure.dart';
import '../../entities/forecast_entity.dart';
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
    return await _repo.getForecast(lat, lon);
  }
}
