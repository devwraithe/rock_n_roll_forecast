import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/remote_datasources/weather_remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/env_config.dart';

import '../../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Load and init environment variables
  EnvConfig.initialize(
    baseUrl: const String.fromEnvironment("BASE_URL"),
    appId: const String.fromEnvironment("APP_ID"),
  );

  late MockHttpService mockHttpService;
  late MockLocationService mockLocationService;
  late MockConnectivityService mockConnectivityService;

  late WeatherRemoteDatasource datasource;

  setUp(() {
    mockHttpService = MockHttpService();
    mockLocationService = MockLocationService();
    mockConnectivityService = MockConnectivityService();

    datasource = WeatherRemoteDatasourceImpl(
      mockHttpService,
      mockLocationService,
      mockConnectivityService,
    );
  });

  const city = "Melbourne, Australia";

  final weatherJson = {
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
  };

  test(
    'Should return weather info when connected to the internet and successful',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => true,
      );
      when(mockLocationService.getCoordinates(city)).thenAnswer(
        (_) async => {
          "latitude": 1.0,
          "longitude": 1.0,
        },
      );
      when(mockHttpService.getRequest(
        any,
        headers: Constants.headers,
        errorMessage: Constants.weatherServerError,
      )).thenAnswer(
        (_) async => weatherJson,
      );

      // Act
      final result = await datasource.getWeather(city);

      // Assert
      expect(result, equals(isA<WeatherModel>()));
      verify(mockConnectivityService.isConnected()).called(1);
      verify(mockLocationService.getCoordinates(city)).called(1);
    },
  );

  test(
    'Should throw NoConnectionException when internet is not available',
    () async {
      // Arrange
      when(mockConnectivityService.isConnected()).thenAnswer(
        (_) async => false,
      );

      // Act & Assert
      expect(
        () => datasource.getWeather(city),
        throwsA(isA<NoConnectionException>()),
      );
    },
  );
}
