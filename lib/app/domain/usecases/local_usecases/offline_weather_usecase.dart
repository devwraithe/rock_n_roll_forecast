import 'package:dartz/dartz.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/weather_entity.dart';
import '../../repositories/local_repository.dart';

abstract class OfflineWeatherUsecase {
  Future<Either<Failure, WeatherEntity?>> execute(String city);
}

class OfflineWeatherUsecaseImpl implements OfflineWeatherUsecase {
  final WeatherLocalRepository _repo;
  OfflineWeatherUsecaseImpl(this._repo);

  @override
  Future<Either<Failure, WeatherEntity?>> execute(String city) async {
    final response = await _repo.offlineWeather(city);
    return response.fold(
      (failure) => Left(failure),
      (result) => Right(result),
    );
  }
}
