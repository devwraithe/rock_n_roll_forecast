import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';
import '../../repositories/remote_repository.dart';

class ForecastUsecase {
  final RemoteRepository _repo;
  ForecastUsecase(this._repo);

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
