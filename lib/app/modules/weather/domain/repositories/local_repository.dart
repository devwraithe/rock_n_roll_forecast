import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/forecast_entity.dart';
import '../entities/weather_entity.dart';

abstract class WeatherLocalRepository {
  Future<Either<Failure, void>> cacheWeather(
    WeatherEntity weather,
    String city,
  );

  Future<Either<Failure, WeatherEntity?>> offlineWeather(
    String city,
  );
}

abstract class ForecastLocalRepository {
  Future<Either<Failure, void>> cacheForecast(
    List<ForecastEntity> forecasts,
    String city,
  );
  Future<Either<Failure, List<ForecastEntity>>> offlineForecast(
    String city,
  );
}
