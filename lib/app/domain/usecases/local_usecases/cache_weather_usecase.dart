import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';

import '../../../core/utilities/errors/failure.dart';

abstract class CacheWeatherUsecase {
  Future<Either<Failure, void>> execute(
    WeatherEntity weather,
    String city,
  );
}

class CacheWeatherUsecaseImpl implements CacheWeatherUsecase {
  final WeatherLocalRepository _repo;
  CacheWeatherUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, void>> execute(
    WeatherEntity weather,
    String city,
  ) async {
    return await _repo.cacheWeather(weather, city);
  }
}
