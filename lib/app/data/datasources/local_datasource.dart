import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/current_weather_entity.dart';

import '../../core/utilities/constants.dart';
import '../../core/utilities/errors/failure.dart';

abstract class LocalDatasource {
  Future<void> cacheCurrentWeather(CurrentWeatherEntity weather, String city);
  Future<CurrentWeatherEntity?> getCachedCurrentWeather(String city);
}

class LocalDatasourceImpl implements LocalDatasource {
  final HiveInterface hiveInterface;
  const LocalDatasourceImpl(this.hiveInterface);

  @override
  Future<void> cacheCurrentWeather(
      CurrentWeatherEntity weather, String city) async {
    try {
      final box = await hiveInterface.openBox('weathers');
      debugPrint("[Caching in Hive for Offline Support]...");

      // Check if the entry already exists in the box
      if (!box.containsKey(city)) {
        // If the entry doesn't exist, add it to the box
        await box.put(city, weather);
      }

      debugPrint("[Cached in Hive, Offline Support Updated]");
      box.close();
    } catch (e) {
      debugPrint("Error - $e");
    }
  }

  @override
  Future<CurrentWeatherEntity?> getCachedCurrentWeather(String city) async {
    try {
      final box = await hiveInterface.openBox('weathers');
      debugPrint("[Retrieving Data Cache from Hive]... $city");

      if (box.containsKey(city)) {
        // If the entity exists, retrieve it from the box and return it
        final weather = box.get(city) as CurrentWeatherEntity;
        debugPrint("[Retrieved Data Cache from Hive]");
        box.close();
        return weather;
      } else {
        // If the entity doesn't exist, throw a CacheException
        debugPrint("Weather entity is not found in cache for city: $city");
        // throw CacheException(Failure(Constants.offlineError));
        throw Constants.offlineError;
      }
    } on HiveError catch (e) {
      // Handle Hive-specific errors
      debugPrint("Hive error occurred: $e");
      throw HiveException(Failure(e.message));
    } catch (e) {
      // Handle other unexpected exceptions
      debugPrint("Error occurred here: $e");
      throw UnexpectedException(Failure(e.toString()));
    }
  }
}
