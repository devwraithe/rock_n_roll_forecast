import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/weather_entity.dart';
import '../../repositories/repository.dart';

class OfflineWeatherUsecase {
  final Repository _repo;
  OfflineWeatherUsecase(this._repo);

  Future<Either<Failure, WeatherEntity?>> execute(String city) async {
    final result = await _repo.offlineWeather(city);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
