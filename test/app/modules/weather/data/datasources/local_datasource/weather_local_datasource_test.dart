import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/weather_local_datasource.dart';

import '../../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late WeatherLocalDatasource datasource;
  late MockLocalStorageService mockLocalStorageService;

  setUp(() {
    mockLocalStorageService = MockLocalStorageService();
    datasource = WeatherLocalDatasourceImpl(
      mockLocalStorageService,
    );
  });

  const city = "Melbourne, Australia";
  final mockWeather = MockWeatherEntity();

  test(
    'Should cache the weather when the cacheRequest method is triggered',
    () async {
      when(mockLocalStorageService.cacheRequest(
        any,
        mockWeather,
        city,
      )).thenAnswer((_) async {});

      await datasource.cacheWeather(mockWeather, city);

      verify(
        mockLocalStorageService.cacheRequest(
          any,
          mockWeather,
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
      )).thenAnswer((_) async => mockWeather);

      await datasource.offlineWeather(city);

      verify(
        mockLocalStorageService.getRequest(
          any,
          city,
        ),
      ).called(1);
    },
  );
}
