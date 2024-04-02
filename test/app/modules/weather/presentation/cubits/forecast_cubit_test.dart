import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/forecast/forecast_state.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/failure.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late ForecastCubit cubit;
  late MockForecastUsecase mockForecastUsecase;

  setUp(() {
    mockForecastUsecase = MockForecastUsecase();
    cubit = ForecastCubit(mockForecastUsecase);
  });

  tearDown(() {
    // Close the cubit after each test
    cubit.close();
  });

  const lat = "0.0";
  const lon = "0.0";
  const location = "Melbourne, Australia";

  const forecastEntity = ForecastEntity(
    dailyTime: 0,
    dailyMinTemp: 0,
    dailyMaxTemp: 0,
    dailyIcon: "d10",
  );

  // Test the initial state of the cubit
  test(
    'initial state should be empty',
    () => expect(
      cubit.state,
      ForecastInitial(),
    ),
  );

  blocTest<ForecastCubit, ForecastState>(
    'Should emit ForecastError when an error occurs',
    setUp: () {
      // when(mockConnectivityService.isConnected()).thenAnswer(
      //   (_) async => true,
      // );
      when(mockForecastUsecase.execute(any)).thenAnswer(
        (_) async => const Left(Failure('Failed to fetch forecast')),
      );
    },
    build: () => cubit,
    act: (cubit) => cubit.getForecast(location),
    expect: () => [
      ForecastLoading(),
      const ForecastError('Failed to fetch forecast'),
    ],
  );

  blocTest<ForecastCubit, ForecastState>(
    'Should emit ForecastLoaded when internet is available and returns forecast',
    setUp: () {
      when(mockForecastUsecase.execute(any)).thenAnswer(
        (_) async => const Right([forecastEntity]),
      );
      // when(mockConnectivityService.isConnected()).thenAnswer(
      //   (_) async => true,
      // );
    },
    build: () => cubit,
    act: (cubit) => cubit.getForecast(location),
    expect: () => [
      ForecastLoading(),
      const ForecastLoaded([forecastEntity]),
    ],
  );
}
