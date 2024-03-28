import 'package:dartz/dartz.dart';

import '../../../../../shared/errors/failure.dart';
import '../../entities/forecast_entity.dart';
import '../../repositories/local_repository.dart';

abstract class OfflineForecastUsecase {
  Future<Either<Failure, List<ForecastEntity>>> execute(String city);
}

class OfflineForecastUsecaseImpl implements OfflineForecastUsecase {
  final ForecastLocalRepository _repo;
  OfflineForecastUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, List<ForecastEntity>>> execute(String city) async {
    return await _repo.offlineForecast(city);
  }
}
