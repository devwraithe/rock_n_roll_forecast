import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/utilities/errors/failure.dart';

abstract class LocalRepository {
  Future<Either<Failure, void>> cacheWeather(
    WeatherEntity weather,
    String city,
  );
  Future<Either<Failure, WeatherEntity?>> offlineWeather(
    String city,
  );
  Future<Either<Failure, void>> cacheForecast(
    List<ForecastEntity> forecasts,
    String city,
  );
  Future<Either<Failure, List<ForecastEntity>>> offlineForecast(
    String city,
  );
}
