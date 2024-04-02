import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/weather_usecase.dart';

import '../../../../shared/helpers/test_helper.mocks.dart';

void main() {
  late WeatherUsecase usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = WeatherUsecaseImpl(mockWeatherRepository);
  });

  const String city = 'Melbourne, Australia';

  final forecasts = MockWeatherEntity();

  test('Should return the weather info', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(mockWeatherRepository.getWeather(any)).thenAnswer(
      (_) async => Right(forecasts),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute(city);

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(Right(forecasts)));
    // Verify that the method has been called on the Repository
    verify(mockWeatherRepository.getWeather(city));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWeatherRepository);
  });
}
