import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';

import '../../../core/utilities/api_paths.dart';
import '../../../core/utilities/constants.dart';
import '../../../core/utilities/errors/exceptions.dart';
import '../../../core/utilities/errors/failure.dart';

class WeatherRemoteDatasourceImpl implements WeatherRemoteDatasource {
  final Client client;
  const WeatherRemoteDatasourceImpl(this.client);

  @override
  Future<WeatherModel> getWeather(String lat, String lon) async {
    try {
      final response = await client.get(
        Uri.parse(ApiUrls.weather(lat, lon)),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw ServerException(Failure(Constants.serverError));
      } else {
        return WeatherModel.fromJson(data);
      }
    } on SocketException {
      throw NetworkException(Failure(Constants.lostConnection));
    } on TimeoutException {
      throw NetworkException(Failure(Constants.connectionTimeout));
    } catch (e) {
      throw UnexpectedException(Failure(e.toString()));
    }
  }
}

class ForecastRemoteDatasourceImpl implements ForecastRemoteDatasource {
  final Client client;

  const ForecastRemoteDatasourceImpl(this.client);

  @override
  Future<List<ForecastModel>> getForecast(
    String lat,
    String lon,
  ) async {
    try {
      final response = await client.get(
        Uri.parse(ApiUrls.forecast(lat, lon)),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw ServerException(Failure(Constants.serverError));
      } else {
        final List forecasts = data['list'];
        return forecasts.map((f) => ForecastModel.fromJson(f)).toList();
      }
    } on SocketException {
      throw NetworkException(Failure(Constants.lostConnection));
    } on TimeoutException {
      throw NetworkException(Failure(Constants.connectionTimeout));
    } catch (e) {
      throw UnexpectedException(Failure(e.toString()));
    }
  }
}
