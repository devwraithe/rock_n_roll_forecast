import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';
import '../../repositories/local_repository.dart';

abstract class OfflineForecastUsecase {
  Future<Either<Failure, List<ForecastEntity>>> execute(String city);
}

class OfflineForecastUsecaseImpl implements OfflineForecastUsecase {
  final ForecastLocalRepository _repo;
  OfflineForecastUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, List<ForecastEntity>>> execute(String city) async {
    final response = await _repo.offlineForecast(city);
    return response.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
