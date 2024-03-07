import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/daily_forecast_entity.dart';
import '../../repositories/local_repository.dart';

class OfflineForecastUsecase {
  final LocalRepository _repo;
  OfflineForecastUsecase(this._repo);

  Future<Either<Failure, List<ForecastEntity>>> execute(String city) async {
    final response = await _repo.offlineForecast(city);
    return response.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
