import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/errors/failure.dart';

abstract class WeatherRemoteRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(
    String lat,
    String lon,
  );
}

abstract class ForecastRemoteRepository {
  Future<Either<Failure, List<ForecastEntity>>> getForecast(
    String lat,
    String lon,
  );
}
