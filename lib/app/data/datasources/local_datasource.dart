import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/utilities/constants.dart';
import '../../core/utilities/errors/failure.dart';

abstract class LocalDatasource {
  Future<void> cacheWeather(WeatherEntity weather, String city);
  Future<WeatherEntity?> offlineWeather(String city);
  Future<void> cacheForecast(List<ForecastEntity> forecasts, String city);
  Future<List<ForecastEntity>> offlineForecasts(String city);
}

class LocalDatasourceImpl implements LocalDatasource {
  final HiveInterface hiveInterface;
  const LocalDatasourceImpl(this.hiveInterface);

  @override
  Future<void> cacheWeather(WeatherEntity weather, String city) async {
    final box = await hiveInterface.openBox('weathers');

    try {
      debugPrint("Storing weathers for offline...");
      // if (!box.containsKey(city)) {
      // If the entry doesn't exist, add it to the box
      await box.put(city, weather);
      // } else {
      //   debugPrint("Weather is cached already!");
      // }
      debugPrint("Weathers stored in offline cache!");
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

  @override
  Future<WeatherEntity?> offlineWeather(String city) async {
    final box = await hiveInterface.openBox('weathers');

    try {
      debugPrint("Gathering resources...");

      if (box.containsKey(city)) {
        // If the entity exists, retrieve it from the box and return it
        final WeatherEntity weather = await box.get(city);
        debugPrint("Retrieved from offline cache!");

        return weather;
      } else {
        // If the entity doesn't exist, throw a CacheException
        debugPrint("$city's weather is not found offline!");
        // throw CacheException(Failure(Constants.offlineError));
        // throw Constants.offlineError;
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

  @override
  Future<void> cacheForecast(
      List<ForecastEntity> forecasts, String city) async {
    final box = await hiveInterface.openBox('forecasts');

    try {
      debugPrint("Storing forecasts for offline...");

      // Remove existing data for the city if it exists
      if (box.containsKey(city)) {
        await box.delete(city);
      }

      // Put the new forecast list for the city into the box
      await box.put(city, forecasts);

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
    } finally {
      box.close();
    }
  }

  @override
  Future<List<ForecastEntity>> offlineForecasts(String city) async {
    final box = await hiveInterface.openBox('forecasts');

    try {
      debugPrint("Gathering offline forecasts for $city...");

      if (box.containsKey(city)) {
        // Retrieve the data from the Hive box
        final dynamic data = box.get(city);

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
