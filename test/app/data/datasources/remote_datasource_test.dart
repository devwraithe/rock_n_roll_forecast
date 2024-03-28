import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/api_paths.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const String lat = "0.0";
  const String lon = "0.0";

  late MockClient mockClient;
  late WeatherRemoteDatasource weatherDatasource;
  late ForecastRemoteDatasource forecastDatasource;

  setUp(() {
    mockClient = MockClient();
    weatherDatasource = WeatherRemoteDatasourceImpl(mockClient);
    forecastDatasource = ForecastRemoteDatasourceImpl(mockClient);
  });

  final weatherJson = jsonEncode(
    {
      "coord": {"lat": 51.51, "lon": -0.13},
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
    },
  );

  final weatherModel = WeatherModel.fromJson(json.decode(weatherJson));

  final forecastJson = jsonEncode({
    "list": [
      {
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
      }
    ]
  });

  final List dataList = json.decode(forecastJson)['list'];
  final List<ForecastModel> forecastModel =
      dataList.map((e) => ForecastModel.fromJson(e)).toList();

  group('should run tests for the WeatherRemoteDatasource', () {
    test(
      'Should return WeatherModel if http call completes successfully',
      () {
        when(
          mockClient.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenAnswer(
          (_) async => Response(
            weatherJson,
            200,
          ),
        );

        final result = weatherDatasource.getWeather(lat, lon);

        expect(result, isA<Future<WeatherModel>>());
        verify(
          mockClient.get(
            Uri.parse(ApiUrls.weather(lat, lon)),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
          ),
        );
      },
    );

    test(
      'Should get the WeatherEntity from remote',
      () async {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(weatherJson, 200),
        );
        final result = await weatherDatasource.getWeather(lat, lon);
        expect(result, equals(weatherModel));
      },
    );

    test(
      'throws an ServerException for other exceptions',
      () async {
        when(
          mockClient.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenThrow(
          ServerException(
            Failure(
              Constants.unknownError,
            ),
          ),
        );

        final call = weatherDatasource.getWeather('lat', 'lon');

        expect(
          () => call,
          throwsA(
            isA<ServerException>(),
          ),
        );
      },
    );

    test(
      'throws a NetworkException if there is no internet connection',
      () async {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenThrow(
          SocketException(
            Constants.lostConnection,
          ),
        );

        final call = weatherDatasource.getWeather('lat', 'lon');

        // Assert
        expect(
          () => call,
          throwsA(
            isA<NetworkException>(),
          ),
        );
      },
    );

    test('throws a NetworkException if internet connection times out',
        () async {
      when(
        mockClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenThrow(
        TimeoutException(
          Constants.connectionTimeout,
        ),
      );

      final call = weatherDatasource.getWeather('lat', 'lon');

      expect(
        () => call,
        throwsA(
          isA<NetworkException>(),
        ),
      );
    });

    test(
      'throws an UnexpectedException for other exceptions',
      () async {
        when(
          mockClient.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenThrow(
          UnexpectedException(
            Failure(
              Constants.unknownError,
            ),
          ),
        );

        final call = weatherDatasource.getWeather('lat', 'lon');

        expect(
          () => call,
          throwsA(
            isA<UnexpectedException>(),
          ),
        );
      },
    );
  });

  group('should run tests for the ForecastRemoteDatasource', () {
    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(
            forecastJson,
            200,
          ),
        );

        final result = forecastDatasource.getForecast(lat, lon);

        expect(result, isA<Future<List<ForecastModel>>>());
        verify(
          mockClient.get(
            Uri.parse(ApiUrls.forecast(lat, lon)),
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Accept': 'application/json',
            },
          ),
        );
      },
    );

    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(forecastJson, 200),
        );
        // act
        final result = await forecastDatasource.getForecast(lat, lon);
        // assert
        expect(result, equals(forecastModel));
      },
    );

    test(
      'throws an ServerException for other exceptions',
      () async {
        when(
          mockClient.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenThrow(
          ServerException(
            Failure(
              Constants.unknownError,
            ),
          ),
        );

        final call = forecastDatasource.getForecast(lat, lon);

        expect(
          () => call,
          throwsA(
            isA<ServerException>(),
          ),
        );
      },
    );

    test(
      'throws a NetworkException if there is no internet connection',
      () async {
        when(mockClient.get(any, headers: anyNamed('headers'))).thenThrow(
          SocketException(
            Constants.lostConnection,
          ),
        );

        final call = forecastDatasource.getForecast('lat', 'lon');

        // Assert
        expect(
          () => call,
          throwsA(
            isA<NetworkException>(),
          ),
        );
      },
    );

    test(
      'throws a NetworkException if there is no internet connection',
      () async {
        when(
          mockClient.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenThrow(
          TimeoutException(
            Constants.connectionTimeout,
          ),
        );

        final call = forecastDatasource.getForecast(lat, lon);

        expect(
          () => call,
          throwsA(
            isA<NetworkException>(),
          ),
        );
      },
    );

    test(
      'throws an UnexpectedException for other exceptions',
      () async {
        when(
          mockClient.get(
            any,
            headers: anyNamed('headers'),
          ),
        ).thenThrow(
          UnexpectedException(
            Failure(
              Constants.unknownError,
            ),
          ),
        );

        final call = forecastDatasource.getForecast(lat, lon);

        expect(
          () => call,
          throwsA(
            isA<UnexpectedException>(),
          ),
        );
      },
    );
  });
}
