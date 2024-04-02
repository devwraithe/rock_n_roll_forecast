import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/repositories/weather_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/constants.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late MockConnectivityService mockConnectivityService;

  late MockWeatherRemoteDatasource mockRemoteDatasource;
  late MockWeatherLocalDatasource mockLocalDatasource;

  late WeatherRepository repository;

  setUp(() {
    mockConnectivityService = MockConnectivityService();

    mockRemoteDatasource = MockWeatherRemoteDatasource();
    mockLocalDatasource = MockWeatherLocalDatasource();

    repository = WeatherRepositoryImpl(
      mockRemoteDatasource,
      mockLocalDatasource,
      mockConnectivityService,
    );
  });

  const String city = 'Melbourne, Australia';

  final forecastJson = json.encode({
    "dt": 1615377600,
    "main": {
      "temp_min": 20,
      "temp_max": 30,
    },
    "weather": [
      {
        "icon": "01d",
      }
    ]
  });

  final forecastModel = ForecastModel.fromJson(json.decode(forecastJson));

  final List<ForecastModel> forecasts = [forecastModel];

  final forecastEntities = forecasts.map((e) {
    return e.toEntity();
  }).toList();

  final weatherJson = json.encode({
    "coord": {
      "lat": 51.51,
      "lon": -0.13,
    },
    "weather": [
      {
        "main": "Clear",
        "description": "clear sky",
        "icon": "01d",
      }
    ],
    "main": {
      "temp": 283,
      "feels_like": 283.0,
      "humidity": 70,
    },
    "wind": {
      "speed": 2.0,
    },
  });

  final weatherModel = WeatherModel.fromJson(json.decode(weatherJson));
  final weatherEntity = weatherModel.toEntity();

  test(
    'Should return weather info when connected to the internet and successful',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => true,
      );
      when(mockRemoteDatasource.getWeather(city)).thenAnswer(
        (_) async => weatherModel,
      );

      // Act
      final result = await repository.getWeather(city);

      // Assert
      expect(result, equals(isA<Right>()));
      verify(mockRemoteDatasource.getWeather(city)).called(1);
      verify(mockLocalDatasource.cacheWeather(weatherEntity, city)).called(1);
    },
  );

  test(
    'Should return weather info when not connected to the internet and successful',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );
      when(mockLocalDatasource.offlineWeather(city)).thenAnswer(
        (_) async => weatherEntity,
      );

      // Act
      final result = await repository.getWeather(city);

      // Assert
      expect(result, equals(isA<Right>()));
      verify(mockLocalDatasource.offlineWeather(city)).called(1);
    },
  );

  test(
    'Should return ServerException when api error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getWeather(city)).thenThrow(
        ServerException(Failure(Constants.weatherServerError)),
      );

      // Act
      final result = await repository.getWeather(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.getWeather(city)).called(1);
    },
  );

  test(
    'Should return NetworkException when caching error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getWeather(city)).thenThrow(
        NetworkException(Failure(Constants.lostConnection)),
      );

      // Act
      final result = await repository.getWeather(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.getWeather(city)).called(1);
    },
  );

  test(
    'Should return CacheException when caching error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getWeather(city)).thenThrow(
        CacheException(Failure(Constants.offlineError)),
      );

      // Act
      final result = await repository.getWeather(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.getWeather(city)).called(1);
    },
  );

  test(
    'Should return a default Left when an unexpected exception occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );
      when(mockLocalDatasource.offlineWeather(city)).thenThrow(
        Left(Failure(Constants.offlineError)),
      );

      // Act
      final result = await repository.getWeather(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockLocalDatasource.offlineWeather(city)).called(1);
    },
  );
}
