import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/utilities/adapters/local_storage_adapter/local_storage_adapter.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/errors/failure.dart';

abstract class LocalDatasource {
  Future<void> cacheWeather(WeatherEntity weather, String city);
  Future<WeatherEntity?> offlineWeather(String city);
  Future<void> cacheForecast(List<ForecastEntity> forecasts, String city);
  Future<List<ForecastEntity>> offlineForecasts(String city);
}

class LocalDatasourceImpl implements LocalDatasource {
  final LocalStorageAdapter localStorageAdapter;

  const LocalDatasourceImpl(this.localStorageAdapter);

  @override
  Future<void> cacheWeather(WeatherEntity weather, String city) async {
    await localStorageAdapter.openBox('weathers');

    try {
      debugPrint("Storing weathers for offline...");
      await localStorageAdapter.put(city, weather);
      debugPrint("Weathers stored in offline cache!");
    } on HiveError catch (e) {
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      debugPrint("An error occurred: $e");
      throw UnexpectedException(Failure(e.toString()));
    }
  }

  @override
  Future<WeatherEntity?> offlineWeather(String city) async {
    await localStorageAdapter.openBox('weathers');

    try {
      final containsCity = await localStorageAdapter.containsKey(city);
      debugPrint("Gathering resources...");

      if (containsCity) {
        // If the entity exists, retrieve it from the box and return it
        final WeatherEntity weather = await localStorageAdapter.get(city);
        debugPrint("Retrieved from offline cache!");

        return weather;
      } else {
        // If the entity doesn't exist, throw a CacheException
        debugPrint("$city's weather is not found offline!");
        // throw CacheException(Failure(Constants.offlineError));
        throw Constants.offlineError;
      }
    } on HiveError catch (e) {
      // Handle Hive-specific errors
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      // Handle other unexpected exceptions
      debugPrint("An error occurred: $e");
      throw UnexpectedException(Failure(e.toString()));
    }
  }

  @override
  Future<void> cacheForecast(
    List<ForecastEntity> forecasts,
    String city,
  ) async {
    await localStorageAdapter.openBox('forecasts');

    try {
      final containsCity = await localStorageAdapter.containsKey(city);
      debugPrint("Storing forecasts for offline...");

      // Remove existing data for the city if it exists
      if (containsCity) {
        await localStorageAdapter.delete(city);
      }

      // Put the new forecast list for the city into the box
      await localStorageAdapter.put(city, forecasts);

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
      throw UnexpectedException(Failure(e.toString()));
    }
  }

  @override
  Future<List<ForecastEntity>> offlineForecasts(String city) async {
    final box = await localStorageAdapter.openBox('forecasts');

    try {
      final containsCity = await localStorageAdapter.containsKey(city);
      debugPrint("Gathering offline forecasts for $city...");

      if (containsCity) {
        // Retrieve the data from the Hive box
        final dynamic data = localStorageAdapter.get(city);

        // Check if the retrieved data is of type List<ForecastEntity>
        if (data is List &&
            data.isNotEmpty &&
            data.every((e) => e is ForecastEntity)) {
          // If the data is of the correct type, cast it to List<ForecastEntity>
          final List<ForecastEntity> forecasts = data.cast<ForecastEntity>();
          debugPrint("Retrieved offline forecasts for $city!");
          for (final forecast in forecasts) {
            debugPrint("Ret Forecast - $forecast");
          }
          return forecasts;
        } else {
          // If the retrieved data is not of the expected type, throw an error
          throw UnexpectedException(Failure("Invalid data type in Hive box"));
        }
      } else {
        // If the entity doesn't exist, throw a CacheException
        debugPrint("$city's forecasts are not found in offline cache!");
        throw Constants.offlineError;
      }
    } on HiveError catch (e) {
      // Handle Hive-specific errors
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      // Handle other unexpected exceptions
      debugPrint("An error occurred: $e");
      throw UnexpectedException(Failure(e.toString()));
    } finally {
      box.close();
    }
  }
}
