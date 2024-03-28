import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_state.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  late WeatherCubit cubit;
  late MockWeatherUsecase mockWeatherUsecase;
  late MockCacheWeatherUsecase mockCacheWeatherUseCase;
  late MockOfflineWeatherUsecase mockOfflineWeatherUsecase;
  late MockConnectivityAdapter mockConnectivityAdapter;

  setUp(() {
    mockWeatherUsecase = MockWeatherUsecase();
    mockCacheWeatherUseCase = MockCacheWeatherUsecase();
    mockOfflineWeatherUsecase = MockOfflineWeatherUsecase();
    mockConnectivityAdapter = MockConnectivityAdapter();

    cubit = WeatherCubit(
      mockWeatherUsecase,
      mockCacheWeatherUseCase,
      mockOfflineWeatherUsecase,
      mockConnectivityAdapter,
    );
  });

  const lat = "0.0";
  const lon = "0.0";
  const location = "Melbourne, Australia";

  tearDown(() {
    // Close the cubit after each test
    cubit.close();
  });

  const weatherEntity = WeatherEntity(
    lon: 0.0,
    lat: 0.0,
    wind: 2,
    main: "Clouds",
    description: "Broken Clouds",
    iconCode: '04n',
    temperature: 10,
    humidity: 85,
    feelsLike: 10,
  );

  // Test the initial state of the cubit
  test(
    'Initial state should be empty',
    () => expect(
      cubit.state,
      WeatherInitial(),
    ),
  );

  blocTest<WeatherCubit, WeatherState>(
    'Should emit WeatherError when an error occurs',
    setUp: () {
      when(mockConnectivityAdapter.isConnected()).thenAnswer(
        (_) async => true,
      );
      when(mockWeatherUsecase.execute(any, any)).thenAnswer(
        (_) async => const Left(Failure('Failed to fetch weather')),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.getWeather(lat, lon, location),
    expect: () => [
      WeatherLoading(),
      const WeatherError('Failed to fetch weather'),
    ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'Should emit WeatherLoaded when internet is available and returns weather',
    setUp: () {
      when(mockWeatherUsecase.execute(any, any)).thenAnswer(
        (_) async => const Right(weatherEntity),
      );
      when(mockCacheWeatherUseCase.execute(any, any)).thenAnswer(
        (_) async => const Right(null),
      );
      when(mockConnectivityAdapter.isConnected()).thenAnswer(
        (_) async => true,
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.getWeather(lat, lon, location),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(weatherEntity),
    ],
  );

  blocTest<WeatherCubit, WeatherState>(
    'Should emit WeatherLoaded when internet is unavailable',
    setUp: () {
      when(mockOfflineWeatherUsecase.execute(any)).thenAnswer(
        (_) async => const Right(weatherEntity),
      );
      when(mockConnectivityAdapter.isConnected()).thenAnswer(
        (_) async => false,
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.getWeather(lat, lon, location),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(weatherEntity),
    ],
  );
}
