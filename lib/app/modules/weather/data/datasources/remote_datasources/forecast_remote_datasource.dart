import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rock_n_roll_forecast/app/shared/services/http_service.dart';

import '../../../../../shared/errors/exceptions.dart';
import '../../../../../shared/errors/failure.dart';
import '../../../../../shared/services/connectivity_service.dart';
import '../../../../../shared/services/location_service.dart';
import '../../../../../shared/utilities/api_paths.dart';
import '../../../../../shared/utilities/constants.dart';
import '../../models/forecast_model.dart';

abstract class ForecastRemoteDatasource {
  Future<List<ForecastModel>> getForecast(String city);
}

class ForecastRemoteDatasourceImpl implements ForecastRemoteDatasource {
  final HttpService http;
  final LocationService locationService;
  final ConnectivityService connectivityService;

  const ForecastRemoteDatasourceImpl(
    this.http,
    this.locationService,
    this.connectivityService,
  );

  @override
  Future<List<ForecastModel>> getForecast(String city) async {
    if (await connectivityService.isConnected()) {
      final coordinates = await locationService.getCoordinates(city);

      final Map<String, dynamic> response = await http.getRequest(
        ApiUrls.forecast(
          coordinates['latitude'].toString(),
          coordinates['latitude'].toString(),
        ),
        headers: Constants.headers,
        errorMessage: Constants.forecastsServerError,
      );

      final List forecasts = response['list'];
      return forecasts.map((f) => ForecastModel.fromJson(f)).toList();
    } else {
      debugPrint("No internet connection available");
      throw const NoConnectionException(Failure("No internet connection"));
    }
  }
}
