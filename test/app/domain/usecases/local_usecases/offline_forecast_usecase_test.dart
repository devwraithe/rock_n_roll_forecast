import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/offline_forecast_usecase.dart';

import '../../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  late OfflineForecastUsecase usecase;
  late MockForecastLocalRepository mockForecastLocalRepository;

  setUp(() {
    mockForecastLocalRepository = MockForecastLocalRepository();
    usecase = OfflineForecastUsecaseImpl(mockForecastLocalRepository);
  });

  const String city = 'Silverstone, UK';
  final forecast = [MockForecastEntity()];

  test('Should return the cached forecast info', () async {
    // "On the fly" implementation of the Repository using the Mockito package.
    when(mockForecastLocalRepository.offlineForecast(any)).thenAnswer(
      (_) async => Right(forecast),
    );

    // The "act" phase of the test. Call the not-yet-existent method.
    final result = await usecase.execute(city);

    // UseCase should simply return whatever was returned from the Repository
    expect(result, equals(Right(forecast)));
    // Verify that the method has been called on the Repository
    verify(mockForecastLocalRepository.offlineForecast(city));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockForecastLocalRepository);
  });
}
