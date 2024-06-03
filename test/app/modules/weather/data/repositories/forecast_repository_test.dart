import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/repositories/forecast_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/forecast_repository.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/constants.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late MockConnectivityService mockConnectivityService;

  late MockForecastRemoteDatasource mockRemoteDatasource;
  late MockForecastLocalDatasource mockLocalDatasource;

  late ForecastRepository repository;

  setUp(() {
    mockConnectivityService = MockConnectivityService();

    mockRemoteDatasource = MockForecastRemoteDatasource();
    mockLocalDatasource = MockForecastLocalDatasource();

    repository = ForecastRepositoryImpl(
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

  test(
    'Should return forecasts list when connected to the internet and successful',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => true,
      );
      when(mockRemoteDatasource.getForecast(city)).thenAnswer(
        (_) async => [forecastModel],
      );

      // Act
      final result = await repository.getForecast(city);

      // Assert
      expect(result, equals(isA<Right>()));
      verify(mockRemoteDatasource.getForecast(city)).called(1);
      verify(mockLocalDatasource.cacheForecast(forecastEntities, city))
          .called(1);
    },
  );

  test(
    'Should return forecast list when not connected to the internet and successful',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );
      when(mockLocalDatasource.offlineForecasts(city)).thenAnswer(
        (_) async => forecastEntities,
      );

      // Act
      final result = await repository.getForecast(city);

      // Assert
      expect(result, equals(isA<Right>()));
      verify(mockLocalDatasource.offlineForecasts(city)).called(1);
    },
  );

  test(
    'Should return ServerException when api error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getForecast(city)).thenThrow(
        ServerException(Failure(Constants.forecastsServerError)),
      );

      // Act
      final result = await repository.getForecast(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.getForecast(city)).called(1);
    },
  );

  test(
    'Should return NetworkException when caching error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getForecast(city)).thenThrow(
        NetworkException(Failure(Constants.lostConnection)),
      );

      // Act
      final result = await repository.getForecast(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.getForecast(city)).called(1);
    },
  );

  test(
    'Should return CacheException when caching error occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer((_) async => true);
      when(mockRemoteDatasource.getForecast(city)).thenThrow(
        CacheException(Failure(Constants.offlineError)),
      );

      // Act
      final result = await repository.getForecast(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockRemoteDatasource.getForecast(city)).called(1);
    },
  );

  test(
    'Should return a default Left when an unexpected exception occurs',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );
      when(mockLocalDatasource.offlineForecasts(city)).thenThrow(
        Left(Failure(Constants.offlineError)),
      );

      // Act
      final result = await repository.getForecast(city);

      // Assert
      expect(result, equals(isA<Left>()));
      verify(mockLocalDatasource.offlineForecasts(city)).called(1);
    },
  );
}
