import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/local_usecases/cache_forecast_usecase.dart';

import '../../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  late CacheForecastUseCase usecase;
  late MockForecastLocalRepository mockForecastLocalRepository;

  setUp(() {
    mockForecastLocalRepository = MockForecastLocalRepository();
    usecase = CacheForecastUseCaseImpl(mockForecastLocalRepository);
  });

  const String city = 'Silverstone, UK';
  final forecast = [MockForecastEntity()];

  test('Should cache the forecast info', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(mockForecastLocalRepository.cacheForecast(any, any)).thenAnswer(
      (_) async => const Right(null),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute(forecast, city);

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(const Right(null)));
    // Verify that the method has been called on the Repository
    verify(mockForecastLocalRepository.cacheForecast(forecast, city));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockForecastLocalRepository);
  });
}
