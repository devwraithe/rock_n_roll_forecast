import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/forecast_local_datasource.dart';

import '../../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late ForecastLocalDatasource datasource;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    datasource = ForecastLocalDatasourceImpl(
      mockLocalStorageService,
    );
  });

  const city = "Melbourne, Australia";
  final mockForecast = MockForecastEntity();
  final forecasts = [mockForecast];

  test(
    'Should cache the weather when the cacheRequest method is triggered',
    () async {
      when(mockLocalStorageService.cacheRequest(
        any,
        mockForecast,
        city,
      )).thenAnswer((_) async {});

      await datasource.cacheForecast(forecasts, city);

      verify(
        mockLocalStorageService.cacheRequest(
          any,
          forecasts,
          city,
        ),
      ).called(1);
    },
  );

  test(
    'Should fetch the weather info that is stored in offline storage',
    () async {
      when(mockLocalStorageService.getRequest(
        any,
        city,
      )).thenAnswer((_) async => forecasts);

      await datasource.offlineForecasts(city);

      verify(
        mockLocalStorageService.getRequest(
          any,
          city,
        ),
      ).called(1);
    },
  );
}
