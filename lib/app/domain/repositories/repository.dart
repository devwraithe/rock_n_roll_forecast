import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/current_weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';

import '../../core/utilities/errors/failure.dart';

abstract class Repository {
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
    String lat,
    String lon,
  );
  Future<Either<Failure, List<DailyForecastEntity>>> fiveDaysForecast(
    String lat,
    String lon,
  );
}
