import 'package:dartz/dartz.dart';

import '../../core/utilities/errors/failure.dart';
import '../entities/weather_entity.dart';
import '../repositories/repository.dart';

class WeatherUsecase {
  final Repository _repo;
  WeatherUsecase(this._repo);

  Future<Either<Failure, WeatherEntity>> execute(
    String lat,
    String lon,
  ) async {
    final result = await _repo.getWeather(lat, lon);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
