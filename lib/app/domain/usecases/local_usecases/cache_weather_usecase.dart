import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';

import '../../../core/utilities/errors/failure.dart';

class CacheWeatherUsecase {
  final LocalRepository _repo;
  CacheWeatherUsecase(this._repo);

  Future<Either<Failure, void>> execute(
    WeatherEntity weather,
    String city,
  ) async {
    final response = await _repo.cacheWeather(weather, city);
    return response.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
