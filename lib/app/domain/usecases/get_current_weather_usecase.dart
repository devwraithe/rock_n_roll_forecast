import 'package:dartz/dartz.dart';

import '../../core/utilities/errors/failure.dart';
import '../entities/current_weather_entity.dart';
import '../repositories/repository.dart';

class GetCurrentWeatherUsecase {
  final Repository _repo;
  GetCurrentWeatherUsecase(this._repo);

  Future<Either<Failure, CurrentWeatherEntity>> execute(
    String lat,
    String lon,
  ) async {
    final result = await _repo.getCurrentWeather(lat, lon);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
