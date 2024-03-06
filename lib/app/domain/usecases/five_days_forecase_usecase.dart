import 'package:dartz/dartz.dart';

import '../../core/utilities/errors/failure.dart';
import '../entities/daily_forecast_entity.dart';
import '../repositories/repository.dart';

class FiveDaysForecastUsecase {
  final Repository _repo;
  FiveDaysForecastUsecase(this._repo);

  Future<Either<Failure, List<DailyForecastEntity>>> execute(
    String lat,
    String lon,
  ) async {
    final result = await _repo.fiveDaysForecast(lat, lon);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
