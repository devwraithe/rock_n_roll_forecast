import 'package:dartz/dartz.dart';

import '../../../../../shared/errors/failure.dart';
import '../../entities/weather_entity.dart';
import '../../repositories/local_repository.dart';

abstract class OfflineWeatherUsecase {
  Future<Either<Failure, WeatherEntity?>> execute(String city);
}

class OfflineWeatherUsecaseImpl implements OfflineWeatherUsecase {
  final WeatherLocalRepository _repo;

  // Constructor for initializing the use case with a [WeatherLocalRepository] instance.
  OfflineWeatherUsecaseImpl(this._repo);

  // Executes the use case to retrieve weather data for the specified [city].
  // Returns an `Either` type representing success ([Right]) or failure ([Left]) cases.
  // The failure will be returning exceptions from the repository as well
  @override
  Future<Either<Failure, WeatherEntity?>> execute(String city) async {
    return await _repo.offlineWeather(city);
  }
}
