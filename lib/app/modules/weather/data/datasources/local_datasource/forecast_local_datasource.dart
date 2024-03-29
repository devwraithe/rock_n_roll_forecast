import 'dart:async';

import 'package:rock_n_roll_forecast/app/shared/services/local_storage_service.dart';

import '../../../../../shared/errors/exceptions.dart';
import '../../../../../shared/errors/failure.dart';
import '../../../../../shared/utilities/constants.dart';
import '../../../domain/entities/forecast_entity.dart';

abstract class ForecastLocalDatasource {
  Future<void> cacheForecast(List<ForecastEntity> forecasts, String city);
  Future<List<ForecastEntity>> offlineForecasts(String city);
}

class ForecastLocalDatasourceImpl implements ForecastLocalDatasource {
  final LocalStorageService localStorageService;

  const ForecastLocalDatasourceImpl(this.localStorageService);

  @override
  Future<void> cacheForecast(
    List<ForecastEntity> forecasts,
    String city,
  ) async {
    final response = await localStorageService.cacheRequest(
      Constants.forecastsBox,
      forecasts,
      city,
    );

    return response;
  }

  @override
  Future<List<ForecastEntity>> offlineForecasts(
    String city,
  ) async {
    final result = await localStorageService.getRequest(
      Constants.forecastsBox,
      city,
    );

    if (result is List<dynamic>) {
      return result.map((e) => e as ForecastEntity).toList();
    } else {
      throw HiveException(Failure(Constants.invalidError));
    }
  }
}
