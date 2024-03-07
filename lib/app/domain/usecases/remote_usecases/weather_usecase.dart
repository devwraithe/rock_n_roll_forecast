import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
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
    final result = await _repo.getWeather(lat, lon);
    return result.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
