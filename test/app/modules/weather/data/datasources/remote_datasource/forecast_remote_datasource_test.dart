import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/remote_datasources/forecast_remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/env_config.dart';

import '../../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  EnvConfig.initialize(
    baseUrl: const String.fromEnvironment("BASE_URL"),
    appId: const String.fromEnvironment("APP_ID"),
  );

  late MockHttpService mockHttpService;
  late MockLocationService mockLocationService;
  late MockConnectivityService mockConnectivityService;

  late ForecastRemoteDatasource datasource;

  setUp(() {
    mockHttpService = MockHttpService();
    mockLocationService = MockLocationService();
    mockConnectivityService = MockConnectivityService();

    datasource = ForecastRemoteDatasourceImpl(
      mockHttpService,
      mockLocationService,
      mockConnectivityService,
    );
  });

  const city = "Melbourne, Australia";

  final forecastJson = {
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
  };

  test(
    'Should return forecasts list when connected to the internet and successful',
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
        errorMessage: Constants.forecastsServerError,
      )).thenAnswer(
        (_) async => forecastJson,
      );

      // Act
      final result = await datasource.getForecast(city);

      // Assert
      expect(result, equals(isA<List<ForecastModel>>()));
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
        () => datasource.getForecast(city),
        throwsA(isA<NoConnectionException>()),
      );
    },
  );
}
