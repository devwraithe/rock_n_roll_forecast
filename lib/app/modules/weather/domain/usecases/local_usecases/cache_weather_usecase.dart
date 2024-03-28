import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/local_repository.dart';

import '../../../../../shared/errors/failure.dart';
import '../../entities/weather_entity.dart';

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
