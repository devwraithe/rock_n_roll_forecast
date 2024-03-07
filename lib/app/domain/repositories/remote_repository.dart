import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/utilities/errors/failure.dart';

abstract class RemoteRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(
    String lat,
    String lon,
  );
  Future<Either<Failure, List<ForecastEntity>>> getForecast(
    String lat,
    String lon,
  );
}
