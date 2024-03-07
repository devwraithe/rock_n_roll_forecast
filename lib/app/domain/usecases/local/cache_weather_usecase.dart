import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../repositories/repository.dart';

class CacheWeatherUsecase {
  final Repository _repo;
  CacheWeatherUsecase(this._repo);

  Future<Either<Failure, void>> execute(
      WeatherEntity weather, String city) async {
    return await _repo.cacheWeather(weather, city);
  }
}
