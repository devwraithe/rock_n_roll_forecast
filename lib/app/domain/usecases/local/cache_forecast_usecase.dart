import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';
import '../../repositories/repository.dart';

class CacheForecastUsecase {
  final Repository _repo;
  CacheForecastUsecase(this._repo);

  Future<Either<Failure, void>> execute(
      List<ForecastEntity> forecast, String city) async {
    return await _repo.cacheForecast(forecast, city);
  }
}
