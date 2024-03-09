import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource_impl.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const city = 'Silverstone, UK';

  group('WeatherLocalDatasourceImpl', () {
    late WeatherLocalDatasourceImpl datasource;
    late MockLocalStorageAdapter mockLocalStorageAdapter;

    setUp(() {
      mockLocalStorageAdapter = MockLocalStorageAdapter();
      datasource = WeatherLocalDatasourceImpl(mockLocalStorageAdapter);
    });

    test('cacheWeather should call put method on LocalStorageAdapter',
        () async {
      final weather = MockWeatherEntity();

      when(mockLocalStorageAdapter.openBox("weathers")).thenAnswer(
        (_) async => MockBox(),
      );
      when(mockLocalStorageAdapter.put(city, any)).thenAnswer(
        (_) async {},
      );

      await datasource.cacheWeather(weather, city);

      verifyNever(mockLocalStorageAdapter.put(city, weather));
    });
  });
}
