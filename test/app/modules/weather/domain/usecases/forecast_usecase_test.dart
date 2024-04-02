import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/forecast_usecase.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late ForecastUsecase usecase;
  late MockForecastRepository mockForecastRemoteRepository;

  setUp(() {
    mockForecastRemoteRepository = MockForecastRepository();
    usecase = ForecastUsecaseImpl(mockForecastRemoteRepository);
  });

  const String lat = '40.7128';
  const String lon = '-74.0060';

  const String city = "Melbourne, Australia";

  final forecasts = [
    const ForecastEntity(
      dailyTime: 1615478400,
      dailyMinTemp: 20,
      dailyMaxTemp: 30,
      dailyIcon: '01d',
    ),
  ];

  test('Should return list of forecast entities', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(mockForecastRemoteRepository.getForecast(any)).thenAnswer(
      (_) async => Right(forecasts),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute(city);

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(Right(forecasts)));
    // Verify that the method has been called on the Repository
    verify(mockForecastRemoteRepository.getForecast(city));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockForecastRemoteRepository);
  });
}
