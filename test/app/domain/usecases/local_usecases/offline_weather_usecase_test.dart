import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/offline_weather_usecase.dart';

import '../../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  late OfflineWeatherUsecase usecase;
  late MockWeatherLocalRepository mockWeatherLocalRepository;

  setUp(() {
    mockWeatherLocalRepository = MockWeatherLocalRepository();
    usecase = OfflineWeatherUsecaseImpl(mockWeatherLocalRepository);
  });

  const String city = 'Silverstone, UK';
  final weather = MockWeatherEntity();

  test('Should return the cached weather info', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(mockWeatherLocalRepository.offlineWeather(any)).thenAnswer(
      (_) async => Right(weather),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute(city);

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(Right(weather)));
    // Verify that the method has been called on the Repository
    verify(mockWeatherLocalRepository.offlineWeather(city));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockWeatherLocalRepository);
  });
}
