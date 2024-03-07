import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';
import '../../repositories/repository.dart';

class OfflineForecastUsecase {
  final Repository _repo;
  OfflineForecastUsecase(this._repo);

  Future<Either<Failure, List<ForecastEntity>>> execute(String city) async {
    final result = await _repo.offlineForecast(city);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
