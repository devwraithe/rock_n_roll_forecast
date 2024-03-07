import 'package:rock_n_roll_forecast/app/domain/entities/current_weather_entity.dart';

import '../../repositories/repository.dart';

class CacheCurrentWeatherUsecase {
  final Repository _repo;
  CacheCurrentWeatherUsecase(this._repo);

  Future<void> execute(CurrentWeatherEntity weather, String city) async {
    return await _repo.cacheCurrentWeather(weather, city);
  }
}
