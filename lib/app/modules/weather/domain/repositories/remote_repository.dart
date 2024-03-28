import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/forecast_entity.dart';
import '../entities/weather_entity.dart';

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
