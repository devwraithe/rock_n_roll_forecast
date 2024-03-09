import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../../core/utilities/adapters/local_storage_adapter/local_storage_adapter.dart';
import '../../../core/utilities/constants.dart';
import '../../../core/utilities/errors/failure.dart';
import 'local_datasource.dart';

class WeatherLocalDatasourceImpl implements WeatherLocalDatasource {
  final LocalStorageAdapter localStorageAdapter;
  const WeatherLocalDatasourceImpl(this.localStorageAdapter);

  @override
  Future<void> cacheWeather(WeatherEntity weather, String city) async {
    final localStorage = await localStorageAdapter.openBox('weathers');

    try {
      debugPrint("Storing weathers for offline...");
      await localStorage.put(city, weather);
      debugPrint("Weathers stored in offline cache!");
    } on HiveError catch (e) {
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      debugPrint("An error occurred: $e");
      throw CacheException(Failure(e.toString()));
    }
  }

  @override
  Future<WeatherEntity?> offlineWeather(String city) async {
    final localStorage = await localStorageAdapter.openBox('weathers');

    try {
      final containsCity = await localStorageAdapter.containsKey(city);
      debugPrint("Gathering resources...");

      if (containsCity) {
        // If the entity exists, retrieve it from the box and return it
        final WeatherEntity weather = localStorage.get(city);
        debugPrint("Retrieved from offline cache!");
        return weather;
      } else {
        // If the entity doesn't exist, throw a CacheException
        debugPrint("$city's weather is not found offline!");
        throw Constants.offlineError;
        // throw Constants.offlineError;
      }
    } on HiveError catch (e) {
      // Handle Hive-specific errors
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      // Handle other unexpected exceptions
      debugPrint("An error occurred: $e");
      throw CacheException(Failure(e.toString()));
    }
  }
}

class ForecastLocalDatasourceImpl implements ForecastLocalDatasource {
  final LocalStorageAdapter localStorageAdapter;
  const ForecastLocalDatasourceImpl(this.localStorageAdapter);

  @override
  Future<void> cacheForecast(
    List<ForecastEntity> forecasts,
    String city,
  ) async {
    final localStorage = await localStorageAdapter.openBox('forecasts');

    try {
      final containsCity = await localStorageAdapter.containsKey(city);
      debugPrint("Storing forecasts for offline...");

      // Remove existing data for the city if it exists
      if (containsCity) {
        localStorage.delete(city);
      }

      // Put the new forecast list for the city into the box
      localStorage.put(city, forecasts);

      debugPrint("Forecasts stored in offline cache for $city!");
      for (final forecast in forecasts) {
        debugPrint("Forecast - $forecast");
      }
    } on HiveError catch (e) {
      // Handle Hive-specific errors
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      // Handle other unexpected exceptions
      debugPrint("An error occurred: $e");
      throw CacheException(Failure(e.toString()));
    }
  }

  @override
  Future<List<ForecastEntity>> offlineForecasts(String city) async {
    await localStorageAdapter.openBox('forecasts');

    try {
      final containsCity = await localStorageAdapter.containsKey(city);
      debugPrint("Gathering offline forecasts for $city...");

      if (containsCity) {
        // Retrieve the data from the Hive box
        final dynamic data = await localStorageAdapter.get(city);

        // Check if the retrieved data is of type List<dynamic>
        if (data is List<dynamic>) {
          // Map the dynamic list to List<ForecastEntity>
          final List<ForecastEntity> forecasts = data as List<ForecastEntity>;
          debugPrint("Retrieved offline forecasts for $city!");
          return forecasts;
        } else {
          // If the retrieved data is not of the expected type, throw an error
          throw Constants.invalidError;
        }
      } else {
        // If the entity doesn't exist, throw a CacheException
        debugPrint("$city's forecasts are not found offline!");
        throw Constants.offlineError;
      }
    } on HiveError catch (e) {
      // Handle Hive-specific errors
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.toString()));
    } catch (e) {
      // Handle other unexpected exceptions
      debugPrint("An error occurred: $e");
      throw CacheException(Failure(e.toString()));
    }
  }
}
