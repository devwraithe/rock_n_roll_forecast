import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/weather_repository.dart';

import '../../../../shared/errors/failure.dart';
import '../entities/weather_entity.dart';

abstract class WeatherUsecase {
  Future<Either<Failure, WeatherEntity>> execute(String city);
}

class WeatherUsecaseImpl implements WeatherUsecase {
  final WeatherRepository _repo;
  WeatherUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, WeatherEntity>> execute(String city) async {
    return await _repo.getWeather(city);
  }
}
