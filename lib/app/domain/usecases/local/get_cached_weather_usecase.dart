import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/utilities/errors/failure.dart';
import '../../entities/current_weather_entity.dart';
import '../../repositories/repository.dart';

class GetCachedWeatherUsecase {
  final Repository _repo;
  GetCachedWeatherUsecase(this._repo);

  Future<Either<Failure, CurrentWeatherEntity?>> execute(String city) async {
    final result = await _repo.getCachedWeather(city);
    return result.fold(
      (failure) {
        debugPrint("Failure - ${failure.message}");
        return Left(failure);
      },
      (result) => Right(result),
    );
  }
}
