import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../entities/weather_entity.dart';
import '../../repositories/remote_repository.dart';

abstract class WeatherUsecase {
  Future<Either<Failure, WeatherEntity>> execute(
    String lat,
    String lon,
  );
}

class WeatherUsecaseImpl implements WeatherUsecase {
  final WeatherRemoteRepository _repo;
  WeatherUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, WeatherEntity>> execute(
    String lat,
    String lon,
  ) async {
    return await _repo.getWeather(lat, lon);
  }
}
