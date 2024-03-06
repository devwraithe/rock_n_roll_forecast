import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:rock_n_roll_forecast/app/data/models/current_weather_model.dart';
import 'package:rock_n_roll_forecast/app/data/models/daily_forecast_model.dart';

import '../../core/utilities/api_paths.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/errors/exceptions.dart';
import '../../core/utilities/errors/failure.dart';

abstract class RemoteDatasource {
  Future<CurrentWeatherModel> getCurrentWeather(String lat, String lon);
  Future<List<DailyForecastModel>> fiveDaysForecast(String lat, String lon);
}

class RemoteDatasourceImpl implements RemoteDatasource {
  final Client client;
  const RemoteDatasourceImpl(this.client);

  @override
  Future<CurrentWeatherModel> getCurrentWeather(String lat, String lon) async {
    try {
      final response = await client.get(
        Uri.parse(ApiUrls.currentWeather(lat, lon)),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode != 200) {
        throw ServerException(Failure(Constants.serverError));
      } else {
        return CurrentWeatherModel.fromJson(data);
      }
    } on SocketException {
      throw NetworkException(Failure(Constants.lostConnection));
    } on TimeoutException {
      throw NetworkException(Failure(Constants.timeout));
    } catch (e) {
      throw ServerException(Failure(e.toString()));
    }
  }

  @override
  Future<List<DailyForecastModel>> fiveDaysForecast(
      String lat, String lon) async {
    try {
      final response = await client.get(
        Uri.parse(ApiUrls.fiveDaysForecast(lat, lon)),
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
        return forecasts.map((f) => DailyForecastModel.fromJson(f)).toList();
      }
    } on SocketException {
      throw NetworkException(Failure(Constants.lostConnection));
    } on TimeoutException {
      throw NetworkException(Failure(Constants.timeout));
    } catch (e) {
      throw ServerException(Failure(e.toString()));
    }
  }
}
