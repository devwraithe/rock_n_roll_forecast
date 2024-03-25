import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/data/repositories/remote_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/remote_repository.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const String lat = '0.0';
  const String lon = '0.0';

  late WeatherRemoteRepository weatherRepository;
  late ForecastRemoteRepository forecastRepository;
  late MockWeatherRemoteDatasource mockWeatherRemoteDatasource;
  late MockForecastRemoteDatasource mockForecastRemoteDatasource;

  setUp(() {
    mockWeatherRemoteDatasource = MockWeatherRemoteDatasource();
    mockForecastRemoteDatasource = MockForecastRemoteDatasource();

    weatherRepository = WeatherRemoteRepositoryImpl(
      mockWeatherRemoteDatasource,
    );
    forecastRepository = ForecastRemoteRepositoryImpl(
      mockForecastRemoteDatasource,
    );
  });

  group(
    "Should run tests for WeatherRemoteRepository",
    () {
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

      test(
        'Should return data when the call to remote data source is successful',
        () async {
          when(mockWeatherRemoteDatasource.getWeather(lat, lon)).thenAnswer(
            (_) async => weatherModel,
          );

          final result = await weatherRepository.getWeather(lat, lon);

          verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
          expect(result, equals(Right(weatherModel.toEntity())));
        },
      );

      test(
        'Should return server exception when the call to remote data source is unsuccessful',
        () async {
          when(mockWeatherRemoteDatasource.getWeather(lat, lon)).thenThrow(
            ServerException(
              Failure(
                Constants.weatherServerError,
              ),
            ),
          );

          final result = await weatherRepository.getWeather(lat, lon);

          verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
          expect(
            result,
            equals(
              Left(
                Failure(Constants.weatherServerError),
              ),
            ),
          );
          expect(result.isLeft(), true);
        },
      );

      test(
        'Should return network exception when network is unavailable',
        () async {
          when(mockWeatherRemoteDatasource.getWeather(lat, lon)).thenThrow(
            NetworkException(
              Failure(Constants.lostConnection),
            ),
          );

          final result = await weatherRepository.getWeather(lat, lon);

          verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
          expect(
            result,
            equals(
              Left(
                Failure(Constants.lostConnection),
              ),
            ),
          );
          expect(result.isLeft(), true);
        },
      );

      test(
        'Should return unexpected exception when other exceptions are thrown',
        () async {
          when(mockWeatherRemoteDatasource.getWeather(lat, lon)).thenThrow(
            UnexpectedException(
              Failure(Constants.unknownError),
            ),
          );

          final result = await weatherRepository.getWeather(lat, lon);

          verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
          expect(
            result,
            equals(
              Left(
                Failure(Constants.unknownError),
              ),
            ),
          );
          expect(result.isLeft(), true);
        },
      );
    },
  );

  group(
    "Should run tests for ForecastRemoteRepository",
    () {
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

      test(
        'Should return data when the call to remote data source is successful',
        () async {
          when(mockForecastRemoteDatasource.getForecast(lat, lon)).thenAnswer(
            (_) async => forecasts,
          );

          final result = await forecastRepository.getForecast(lat, lon);

          verify(mockForecastRemoteDatasource.getForecast(lat, lon));
          expect(
            result.getOrElse(() => throw Exception()),
            equals(
              forecasts.map((e) => e.toEntity()).toList(),
            ),
          );
        },
      );

      test(
        'Should return server exception when the call to remote data source is unsuccessful',
        () async {
          when(mockForecastRemoteDatasource.getForecast(lat, lon)).thenThrow(
            ServerException(
              Failure(
                Constants.forecastsServerError,
              ),
            ),
          );

          final result = await forecastRepository.getForecast(lat, lon);

          verify(mockForecastRemoteDatasource.getForecast(lat, lon));
          expect(
            result,
            equals(
              Left(
                Failure(Constants.forecastsServerError),
              ),
            ),
          );
          expect(result.isLeft(), true);
        },
      );

      test(
        'Should return network exception when network is unavailable',
        () async {
          when(mockForecastRemoteDatasource.getForecast(lat, lon)).thenThrow(
            NetworkException(
              Failure(Constants.lostConnection),
            ),
          );

          final result = await forecastRepository.getForecast(lat, lon);

          verify(mockForecastRemoteDatasource.getForecast(lat, lon));
          expect(
            result,
            equals(
              Left(
                Failure(Constants.lostConnection),
              ),
            ),
          );
          expect(result.isLeft(), true);
        },
      );

      test(
        'Should return unexpected exception when other exceptions are thrown',
        () async {
          when(mockForecastRemoteDatasource.getForecast(lat, lon)).thenThrow(
            UnexpectedException(
              Failure(Constants.unknownError),
            ),
          );

          final result = await forecastRepository.getForecast(lat, lon);

          verify(mockForecastRemoteDatasource.getForecast(lat, lon));
          expect(
            result,
            equals(
              Left(
                Failure(Constants.unknownError),
              ),
            ),
          );
          expect(result.isLeft(), true);
        },
      );
    },
  );
}
