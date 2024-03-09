import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/data/repositories/local_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const String city = 'Silverstone, UK';

  late ForecastLocalRepository forecastRepository;
  late MockForecastLocalDatasource mockForecastLocalDatasource;
  late WeatherLocalRepository weatherRepository;
  late MockWeatherLocalDatasource mockWeatherLocalDatasource;

  setUp(() {
    mockWeatherLocalDatasource = MockWeatherLocalDatasource();
    weatherRepository = WeatherLocalRepositoryImpl(
      mockWeatherLocalDatasource,
    );
    mockForecastLocalDatasource = MockForecastLocalDatasource();
    forecastRepository = ForecastLocalRepositoryImpl(
      mockForecastLocalDatasource,
    );
  });

  group('should run tests for WeatherLocalRepositoryImpl', () {
    test('cacheWeather should return Right(null) on success', () async {
      // Arrange
      final weatherEntity = MockWeatherEntity();

      when(mockWeatherLocalDatasource.cacheWeather(weatherEntity, city))
          .thenAnswer(
        (_) async {},
      );

      // Act
      final result = await weatherRepository.cacheWeather(weatherEntity, city);

      // Assert
      expect(result, equals(const Right(null)));
      verify(mockWeatherLocalDatasource.cacheWeather(weatherEntity, city))
          .called(1);
    });

    test('offlineWeather should return WeatherEntity on success', () async {
      // Arrange
      final weatherEntity = MockWeatherEntity();

      when(mockWeatherLocalDatasource.offlineWeather(city)).thenAnswer(
        (_) async => weatherEntity,
      );

      // Act
      final result = await weatherRepository.offlineWeather(city);

      // Assert
      expect(result, equals(Right(weatherEntity)));
      verify(mockWeatherLocalDatasource.offlineWeather(city)).called(1);
    });

    test('should return a Failure on CacheException', () async {
      // create a server exception with the corresponding failure
      final exception = CacheException(Failure(Constants.offlineError));

      // set up the behavior of the mock remote data source to throw the server exception
      when(mockWeatherLocalDatasource.offlineWeather(city))
          .thenThrow(exception);

      // call the repository method and get the result
      final result = await weatherRepository.offlineWeather(city);

      // verify the result is of the expected type and contains the correct failure
      // expect(result, isA<Left<Failure, List<WeatherEntity>>>());
      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    test('should return a Failure on HiveException', () async {
      // create a server exception with the corresponding failure
      final exception = HiveException(Failure(Constants.offlineError));

      // set up the behavior of the mock remote data source to throw the server exception
      when(mockWeatherLocalDatasource.offlineWeather(city))
          .thenThrow(exception);

      // call the repository method and get the result
      final result = await weatherRepository.offlineWeather(city);

      // verify the result is of the expected type and contains the correct failure
      // expect(result, isA<Left<Failure, List<WeatherEntity>>>());
      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });
  });

  group('should run tests for ForecastLocalRepositoryImpl', () {
    test('cacheForecast should return Right(null) on success', () async {
      // Arrange
      final forecast = [MockForecastEntity()];
      when(mockForecastLocalDatasource.cacheForecast(forecast, city))
          .thenAnswer((_) async {});

      // Act
      final result = await forecastRepository.cacheForecast(forecast, city);

      // Assert
      expect(result, equals(const Right(null)));
      verify(mockForecastLocalDatasource.cacheForecast(forecast, city))
          .called(1);
    });

    test('offlineWeather should return WeatherEntity on success', () async {
      // Arrange
      final forecasts = [MockForecastEntity()];

      when(mockForecastLocalDatasource.offlineForecasts(city)).thenAnswer(
        (_) async => forecasts,
      );

      // Act
      final result = await forecastRepository.offlineForecast(city);

      // Assert
      expect(result, equals(Right(forecasts)));
      verify(mockForecastLocalDatasource.offlineForecasts(city)).called(1);
    });

    test('should return a Failure on CacheException', () async {
      // create a server exception with the corresponding failure
      final exception = CacheException(Failure(Constants.offlineError));

      // set up the behavior of the mock remote data source to throw the server exception
      when(mockForecastLocalDatasource.offlineForecasts(city))
          .thenThrow(exception);

      // call the repository method and get the result
      final result = await forecastRepository.offlineForecast(city);

      // verify the result is of the expected type and contains the correct failure
      expect(result, isA<Left<Failure, List<ForecastEntity>>>());
      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    test('should return a Failure on HiveException', () async {
      // create a server exception with the corresponding failure
      final exception = HiveException(Failure(Constants.offlineError));

      // set up the behavior of the mock remote data source to throw the server exception
      when(mockForecastLocalDatasource.offlineForecasts(city))
          .thenThrow(exception);

      // call the repository method and get the result
      final result = await forecastRepository.offlineForecast(city);

      // verify the result is of the expected type and contains the correct failure
      expect(result, isA<Left<Failure, List<ForecastEntity>>>());
      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });
  });
}
