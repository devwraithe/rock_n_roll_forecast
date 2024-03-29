import 'package:dartz/dartz.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(String city);
}
