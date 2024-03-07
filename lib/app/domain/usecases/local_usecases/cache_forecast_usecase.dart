import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';

class CacheForecastUsecase {
  final LocalRepository _repo;
  CacheForecastUsecase(this._repo);

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
