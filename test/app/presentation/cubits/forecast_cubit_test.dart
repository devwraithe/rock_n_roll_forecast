import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_state.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  group('ForecastCubit', () {
    late ForecastCubit cubit;
    late MockForecastUsecase mockForecastUsecase;
    late MockCacheForecastUseCase mockCacheForecastUseCase;
    late MockOfflineForecastUsecase mockOfflineForecastUsecase;
    late MockConnectivityAdapter mockConnectivityAdapter;

    setUp(() {
      mockForecastUsecase = MockForecastUsecase();
      mockCacheForecastUseCase = MockCacheForecastUseCase();
      mockOfflineForecastUsecase = MockOfflineForecastUsecase();
      mockConnectivityAdapter = MockConnectivityAdapter();

      cubit = ForecastCubit(
        mockForecastUsecase,
        mockCacheForecastUseCase,
        mockOfflineForecastUsecase,
        mockConnectivityAdapter,
      );
    });

    tearDown(() {
      // close the cubit after each test
      cubit.close();
    });

    const forecastEntity = ForecastEntity(
      dailyTime: 0,
      dailyMinTemp: 0,
      dailyMaxTemp: 0,
      dailyIcon: "d10",
    );

    // test the initial state of the cubit
    test(
      'initial state should be empty',
      () => expect(
        cubit.state,
        ForecastInitial(),
      ),
    );

    blocTest<ForecastCubit, ForecastState>(
      'emits ForecastError when an error occurs',
      setUp: () {
        when(mockConnectivityAdapter.isConnected()).thenAnswer(
          (_) async => true,
        );
        when(mockForecastUsecase.execute(any, any)).thenAnswer(
          (_) async => const Left(Failure('Failed to fetch forecast')),
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.getForecast('lat', 'lon', 'city'),
      expect: () => [
        ForecastLoading(),
        const ForecastError('Failed to fetch forecast'),
      ],
    );

    blocTest<ForecastCubit, ForecastState>(
      'emits ForecastLoaded when internet is available and returns forecast',
      setUp: () {
        // set up the mock behavior for usecase and connectivity
        when(mockForecastUsecase.execute(any, any)).thenAnswer(
          (_) async => const Right([forecastEntity]),
        );
        when(mockCacheForecastUseCase.execute(any, any)).thenAnswer(
          (_) async => const Right(null),
        );
        when(mockConnectivityAdapter.isConnected()).thenAnswer(
          (_) async => true,
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.getForecast('lat', 'lon', 'city'),
      expect: () => [
        ForecastLoading(),
        const ForecastLoaded([forecastEntity]),
      ],
    );

    blocTest<ForecastCubit, ForecastState>(
      'emits ForecastLoaded when internet is unavailable',
      setUp: () {
        when(mockOfflineForecastUsecase.execute(any)).thenAnswer(
          (_) async => const Right([forecastEntity]),
        );
        when(mockConnectivityAdapter.isConnected()).thenAnswer(
          (_) async => false,
        );
      },
      build: () => cubit,
      act: (cubit) => cubit.getForecast('lat', 'lon', 'city'),
      expect: () => [
        ForecastLoading(),
        const ForecastLoaded([forecastEntity]),
      ],
    );
  });
}
