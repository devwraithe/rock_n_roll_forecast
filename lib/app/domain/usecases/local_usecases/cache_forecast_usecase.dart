import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';

abstract class CacheForecastUseCase {
  Future<Either<Failure, void>> execute(
    List<ForecastEntity> forecast,
    String city,
  );
}

class CacheForecastUseCaseImpl implements CacheForecastUseCase {
  final ForecastLocalRepository _repo;

  CacheForecastUseCaseImpl(this._repo);

  @override
  Future<Either<Failure, void>> execute(
    List<ForecastEntity> forecast,
    String city,
  ) async {
    final response = await _repo.cacheForecast(forecast, city);
    return response.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
