import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource_impl.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const city = 'Melbourne, Australia';

  late WeatherLocalDatasourceImpl weatherDatasource;
  late ForecastLocalDatasourceImpl forecastDatasource;
  late MockLocalStorageAdapter mockLocalStorageAdapter;
  late MockBox mockBox;

  setUp(
    () {
      mockLocalStorageAdapter = MockLocalStorageAdapter();
      mockBox = MockBox();
      weatherDatasource = WeatherLocalDatasourceImpl(
        mockLocalStorageAdapter,
      );
      forecastDatasource = ForecastLocalDatasourceImpl(
        mockLocalStorageAdapter,
      );
    },
  );

  group(
    'WeatherLocalDatasourceImpl',
    () {
      final weather = MockWeatherEntity();

      test(
        'cacheWeather should call put method on LocalStorageAdapter',
        () async {
          when(mockLocalStorageAdapter.openBox(any)).thenAnswer(
            (_) async => mockBox,
          );

          await weatherDatasource.cacheWeather(weather, city);

          verifyNever(mockLocalStorageAdapter.put(city, weather));
          verifyNever(mockLocalStorageAdapter.close());
        },
      );

      test(
        'cacheWeather should call get method on LocalStorageAdapter',
        () async {
          when(mockLocalStorageAdapter.openBox(any)).thenAnswer(
            (_) async => mockBox,
          );
          when(mockBox.containsKey(city)).thenReturn(true);
          when(mockBox.get(city)).thenReturn(weather);

          final result = await weatherDatasource.offlineWeather(city);

          expect(result, equals(weather));
        },
      );

      test(
        'throws HiveException when forecasts data is not found in the offline cache',
        () async {
          when(
            mockLocalStorageAdapter.openBox(
              Constants.weathersBox,
            ),
          ).thenAnswer(
            (_) async => mockBox,
          );
          when(
            mockBox.containsKey(city),
          ).thenThrow(HiveError(""));

          expect(
            () => weatherDatasource.offlineWeather(city),
            throwsA(
              isA<HiveException>(),
            ),
          );
        },
      );

      test(
        'throws UnexpectedException when forecasts data is not found in the offline cache',
        () async {
          when(
            mockLocalStorageAdapter.openBox(
              Constants.weathersBox,
            ),
          ).thenAnswer(
            (_) async => mockBox,
          );
          when(
            mockBox.containsKey(city),
          ).thenThrow(Exception(""));

          expect(
            () => weatherDatasource.offlineWeather(city),
            throwsA(
              isA<UnexpectedException>(),
            ),
          );
        },
      );

      test(
        'throws CacheException when weather data is not found in the offline cache',
        () async {
          when(
            mockLocalStorageAdapter.openBox(
              Constants.weathersBox,
            ),
          ).thenAnswer(
            (_) async => mockBox,
          );
          when(
            mockBox.containsKey(city),
          ).thenReturn(false);

          expect(
            () => weatherDatasource.offlineWeather(city),
            throwsA(
              isA<CacheException>(),
            ),
          );
        },
      );
    },
  );

  group(
    'ForecastLocalDatasourceImpl',
    () {
      final forecast = MockForecastEntity();
      final forecasts = [forecast];

      test(
        'cacheForecast should call put method on LocalStorageAdapter',
        () async {
          when(
            mockLocalStorageAdapter.openBox(any),
          ).thenAnswer(
            (_) async => mockBox,
          );

          await forecastDatasource.cacheForecast(forecasts, city);

          verifyNever(mockLocalStorageAdapter.put(city, forecasts));
          verifyNever(mockLocalStorageAdapter.close());
        },
      );

      test(
        'offlineForecasts should call get method on LocalStorageAdapter',
        () async {
          when(mockLocalStorageAdapter.openBox(any)).thenAnswer(
            (_) async => mockBox,
          );
          when(mockBox.containsKey(city)).thenReturn(true);
          when(mockBox.get(city)).thenReturn(forecasts);

          final result = await forecastDatasource.offlineForecasts(city);

          expect(result, equals(forecasts));
        },
      );

      test(
        'throws HiveException when forecasts data is not found in the offline cache',
        () async {
          when(
            mockLocalStorageAdapter.openBox(
              Constants.forecastsBox,
            ),
          ).thenAnswer(
            (_) async => mockBox,
          );
          when(
            mockBox.containsKey(city),
          ).thenThrow(HiveError(""));

          expect(
            () => forecastDatasource.offlineForecasts(city),
            throwsA(
              isA<HiveException>(),
            ),
          );
        },
      );

      test(
        'throws UnexpectedException when forecasts data is not found in the offline cache',
        () async {
          when(
            mockLocalStorageAdapter.openBox(
              Constants.forecastsBox,
            ),
          ).thenAnswer(
            (_) async => mockBox,
          );
          when(
            mockBox.containsKey(city),
          ).thenThrow(Exception(""));

          expect(
            () => forecastDatasource.offlineForecasts(city),
            throwsA(
              isA<UnexpectedException>(),
            ),
          );
        },
      );

      test(
        'throws CacheException when forecasts data is not found in the offline cache',
        () async {
          when(
            mockLocalStorageAdapter.openBox(
              Constants.forecastsBox,
            ),
          ).thenAnswer(
            (_) async => mockBox,
          );
          when(
            mockBox.containsKey(city),
          ).thenReturn(false);

          expect(
            () => forecastDatasource.offlineForecasts(city),
            throwsA(
              isA<CacheException>(),
            ),
          );
        },
      );
    },
  );
}
