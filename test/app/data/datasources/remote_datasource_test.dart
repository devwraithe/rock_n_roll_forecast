import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/api_paths.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const String city = "Silverstone, UK";
  const String lat = "52.0915";
  const String lon = "1.0281";
  const String long = "1.0281";

  late MockClient mockClient;
  late WeatherRemoteDatasource weatherDatasource;
  late ForecastRemoteDatasource forecastDatasource;

  setUp(() {
    mockClient = MockClient();
    weatherDatasource = WeatherRemoteDatasourceImpl(mockClient);
    forecastDatasource = ForecastRemoteDatasourceImpl(mockClient);
  });

  final weatherJson = jsonEncode({
    "coord": {"lat": 37.7749, "lon": -122.4194},
    "weather": [
      {"main": "Clear", "description": "clear sky", "icon": "01d"}
    ],
    "main": {"temp": 25.6, "pressure": 1013, "humidity": 60}
  });

  final weatherModel = WeatherModel.fromJson(json.decode(weatherJson));

  final forecastJson = jsonEncode({
    "list": [
      {
        "dt": 1621252800,
        "main": {
          "temp_min": 12,
          "temp_max": 25,
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
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        // Arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(
            weatherJson,
            200,
          ),
        );

        // act
        weatherDatasource.getWeather(lat, lon);

        // assert
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
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(weatherJson, 200),
        );
        // act
        final result = await weatherDatasource.getWeather(lat, lon);
        // assert
        expect(result, equals(weatherModel));
      },
    );

    test(
      'should throw a UnexpectedException when the response code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response('Something went wrong', 404),
        );
        // act
        final call = weatherDatasource.getWeather(lat, lon);
        // assert
        expect(
          () => call,
          throwsA(
            const TypeMatcher<UnexpectedException>(),
          ),
        );
      },
    );

    test('getWeather should throw a UnexpectedException on error', () async {
      // Arrange
      when(
        mockClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => Response('Something', 500));

      // Act & Assert
      expect(
        () => weatherDatasource.getWeather(lat, long),
        throwsA(isA<UnexpectedException>()),
      );
    });
  });

  group('should run tests for the ForecastRemoteDatasource', () {
    test(
      'should preform a GET request on a URL with number being the endpoint and with application/json header',
      () {
        // Arrange
        when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Response(
            forecastJson,
            200,
          ),
        );

        // act
        forecastDatasource.getForecast(lat, lon);

        // assert
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

    test('getForecast should throw a UnexpectedException on error', () async {
      // Arrange
      when(
        mockClient.get(
          any,
          headers: anyNamed('headers'),
        ),
      ).thenThrow(
          (_) async => UnexpectedException(Failure(Constants.serverError)));

      // Act & Assert
      expect(
        () => forecastDatasource.getForecast(lat, long),
        throwsA(isA<UnexpectedException>()),
      );
    });
  });
}
