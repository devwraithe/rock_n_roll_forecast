import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/weather_repository.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/repositories/local_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const String city = 'Melbourne, Australia';

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
    final weatherEntity = MockWeatherEntity();

    test('cacheWeather should return Right(null) on success', () async {
      when(mockWeatherLocalDatasource.cacheWeather(weatherEntity, city))
          .thenAnswer(
        (_) async {},
      );

      final result = await weatherRepository.cacheWeather(weatherEntity, city);

      expect(result, equals(const Right(null)));
      verify(
        mockWeatherLocalDatasource.cacheWeather(
          weatherEntity,
          city,
        ),
      ).called(1);
    });

    test('should return a Failure on CacheException', () async {
      final exception = CacheException(Failure(Constants.offlineError));

      when(
        mockWeatherLocalDatasource.cacheWeather(
          weatherEntity,
          city,
        ),
      ).thenThrow(exception);

      final result = await weatherRepository.cacheWeather(
        weatherEntity,
        city,
      );

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
      final exception = HiveException(Failure(Constants.offlineError));

      when(
        mockWeatherLocalDatasource.cacheWeather(
          weatherEntity,
          city,
        ),
      ).thenThrow(exception);

      final result = await weatherRepository.cacheWeather(weatherEntity, city);

      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    test('should return a Failure on UnexpectedException', () async {
      final exception = UnexpectedException(Failure(Constants.unknownError));

      when(
        mockWeatherLocalDatasource.cacheWeather(
          weatherEntity,
          city,
        ),
      ).thenThrow(exception);

      final result = await weatherRepository.cacheWeather(weatherEntity, city);

      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    // Offline weather tests
    test('offlineWeather should return Right(WeatherEntity) on success',
        () async {
      // Create a mock WeatherEntity instance
      final mockWeatherEntity = MockWeatherEntity();

      // Stub the local data source to return the mock WeatherEntity
      when(mockWeatherLocalDatasource.offlineWeather(city))
          .thenAnswer((_) async => mockWeatherEntity);

      // Call the repository method
      final result = await weatherRepository.offlineWeather(city);

      // Check if the result is a Right containing a WeatherEntity
      expect(result, equals(Right(mockWeatherEntity)));

      // Verify that the local data source method was called
      verify(mockWeatherLocalDatasource.offlineWeather(city)).called(1);
    });

    test('should return a Failure on CacheException', () async {
      final exception = CacheException(Failure(Constants.weatherServerError));

      when(mockWeatherLocalDatasource.offlineWeather(city))
          .thenThrow(exception);

      final result = await weatherRepository.offlineWeather(city);

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
      final exception = HiveException(Failure(Constants.offlineError));

      when(
        mockWeatherLocalDatasource.offlineWeather(city),
      ).thenThrow(exception);

      final result = await weatherRepository.offlineWeather(city);

      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    test('should return a Failure on UnexpectedException(failure)', () async {
      final exception = UnexpectedException(Failure(Constants.unknownError));

      when(
        mockWeatherLocalDatasource.offlineWeather(city),
      ).thenThrow(exception);

      final result = await weatherRepository.offlineWeather(city);

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
    final forecast = [MockForecastEntity()];

    test('cacheForecast should return Right(null) on success', () async {
      when(
        mockForecastLocalDatasource.cacheForecast(
          forecast,
          city,
        ),
      ).thenAnswer(
        (_) async {},
      );

      final result = await forecastRepository.cacheForecast(forecast, city);

      expect(result, equals(const Right(null)));
      verify(
        mockForecastLocalDatasource.cacheForecast(
          forecast,
          city,
        ),
      ).called(1);
    });

    test('should return a Failure on CacheException', () async {
      final exception = CacheException(Failure(Constants.offlineError));

      when(mockForecastLocalDatasource.cacheForecast(forecast, city))
          .thenThrow(exception);

      final result = await forecastRepository.cacheForecast(forecast, city);

      // Expecting Left<Failure, void> instead of Left<Failure, List<ForecastEntity>>
      expect(result, isA<Left<Failure, void>>());
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
      final exception = HiveException(Failure(Constants.offlineError));

      when(mockForecastLocalDatasource.cacheForecast(forecast, city))
          .thenThrow(exception);

      final result = await forecastRepository.cacheForecast(forecast, city);

      expect(result, isA<Left<Failure, void>>());
      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    test('should return a Failure on UnexpectedException(failure)', () async {
      final exception = UnexpectedException(Failure(Constants.offlineError));

      when(mockForecastLocalDatasource.cacheForecast(forecast, city))
          .thenThrow(exception);

      final result = await forecastRepository.cacheForecast(forecast, city);

      expect(result, isA<Left<Failure, void>>());
      expect(result.isLeft(), true);
      expect(
        result.fold(
          (failure) => failure,
          (_) => throw Error(),
        ),
        exception.failure,
      );
    });

    // Offline forecasts
    test('offlineWeather should return WeatherEntity on success', () async {
      final forecasts = [MockForecastEntity()];

      when(mockForecastLocalDatasource.offlineForecasts(city)).thenAnswer(
        (_) async => forecasts,
      );

      final result = await forecastRepository.offlineForecast(city);

      expect(result, equals(Right(forecasts)));
      verify(mockForecastLocalDatasource.offlineForecasts(city)).called(1);
    });

    test('should return a Failure on CacheException', () async {
      final exception = CacheException(Failure(Constants.offlineError));

      when(mockForecastLocalDatasource.offlineForecasts(city))
          .thenThrow(exception);

      final result = await forecastRepository.offlineForecast(city);

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
      final exception = HiveException(Failure(Constants.offlineError));

      when(mockForecastLocalDatasource.offlineForecasts(city))
          .thenThrow(exception);

      final result = await forecastRepository.offlineForecast(city);

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

    test('should return a Failure on UnexpectedException(failure)', () async {
      final exception = UnexpectedException(Failure(Constants.unknownError));

      when(mockForecastLocalDatasource.offlineForecasts(city))
          .thenThrow(exception);

      final result = await forecastRepository.offlineForecast(city);

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
