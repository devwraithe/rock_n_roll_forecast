import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/remote_usecases/forecast_usecase.dart';

import '../../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  late ForecastUsecase usecase;
  late MockForecastRemoteRepository mockForecastRemoteRepository;

  setUp(() {
    mockForecastRemoteRepository = MockForecastRemoteRepository();
    usecase = ForecastUsecaseImpl(mockForecastRemoteRepository);
  });

  const String lat = '40.7128';
  const String lon = '-74.0060';

  final forecasts = [
    const ForecastEntity(
      dailyTime: 1615478400,
      dailyMinTemp: 20,
      dailyMaxTemp: 30,
      dailyIcon: '01d',
    ),
  ];

  test('should return list of forecast entities', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(mockForecastRemoteRepository.getForecast(any, any)).thenAnswer(
      (_) async => Right(forecasts),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute(lat, lon);

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(Right(forecasts)));
    // Verify that the method has been called on the Repository
    verify(mockForecastRemoteRepository.getForecast(lat, lon));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockForecastRemoteRepository);
  });
}
