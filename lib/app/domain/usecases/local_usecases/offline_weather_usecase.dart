import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/weather_entity.dart';
import '../../repositories/local_repository.dart';

class OfflineWeatherUsecase {
  final LocalRepository _repo;
  OfflineWeatherUsecase(this._repo);

  Future<Either<Failure, WeatherEntity?>> execute(String city) async {
    final response = await _repo.offlineWeather(city);
    return response.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
