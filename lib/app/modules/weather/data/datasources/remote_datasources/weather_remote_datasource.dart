import 'package:flutter/cupertino.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/failure.dart';

import '../../../../../shared/errors/exceptions.dart';
import '../../../../../shared/services/connectivity_service.dart';
import '../../../../../shared/services/http_service.dart';
import '../../../../../shared/services/location_service.dart';
import '../../../../../shared/utilities/api_paths.dart';
import '../../../../../shared/utilities/constants.dart';
import '../../models/weather_model.dart';

abstract class WeatherRemoteDatasource {
  Future<WeatherModel> getWeather(String city);
}

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final HttpService http;
  final LocationService locationService;
  final ConnectivityService connectivityService;

  const WeatherRemoteDatasourceImpl(
    this.http,
    this.locationService,
    this.connectivityService,
  );

  @override
  Future<WeatherModel> getWeather(String city) async {
    if (await connectivityService.isConnected()) {
      final coordinates = await locationService.getCoordinates(city);

      final Map<String, dynamic> response = await http.getRequest(
        ApiUrls.weather(
          coordinates['latitude'].toString(),
          coordinates['latitude'].toString(),
        ),
        headers: Constants.headers,
        errorMessage: Constants.weatherServerError,
      );

      return WeatherModel.fromJson(response);
    } else {
      debugPrint("No internet connection available");
      throw const NoConnectionException(Failure("No internet connection"));
    }
  }
}
