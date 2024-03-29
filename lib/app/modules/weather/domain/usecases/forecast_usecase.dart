import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/forecast_entity.dart';
import '../repositories/forecast_repository.dart';

abstract class ForecastUsecase {
  Future<Either<Failure, List<ForecastEntity>>> execute(String city);
}

class ForecastUsecaseImpl implements ForecastUsecase {
  final ForecastRepository _repo;
  ForecastUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, List<ForecastEntity>>> execute(String city) async {
    return await _repo.getForecast(city);
  }
}
