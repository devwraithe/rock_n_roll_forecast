import 'dart:async';

import 'package:rock_n_roll_forecast/app/shared/services/local_storage_service.dart';

import '../../../../../shared/utilities/constants.dart';
import '../../../domain/entities/weather_entity.dart';

abstract class WeatherLocalDatasource {
  Future<void> cacheWeather(WeatherEntity weather, String city);
  Future<WeatherEntity> offlineWeather(String city);
}

class WeatherLocalDatasourceImpl implements WeatherLocalDatasource {
  final LocalStorageService localStorageService;

  const WeatherLocalDatasourceImpl(this.localStorageService);

  @override
  Future<void> cacheWeather(
    WeatherEntity weather,
    String city,
  ) async {
    final response = await localStorageService.cacheRequest(
      Constants.weathersBox,
      weather,
      city,
    );

    return response;
  }

  @override
  Future<WeatherEntity> offlineWeather(
    String city,
  ) async {
    final result = await localStorageService.getRequest(
      Constants.weathersBox,
      city,
    );

    return result;
  }
}
