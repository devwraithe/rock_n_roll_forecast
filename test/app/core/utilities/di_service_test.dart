import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/local_storage_adapter/hive_service.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/forecast_repository.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/weather_repository.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/offline_forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/local_usecases/cache_forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/local_usecases/cache_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/local_usecases/offline_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/remote_usecases/weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/shared/services/di_service.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/adapters/connectivity_adapter/connectivity_plus_adapter.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/adapters/local_storage_adapter/local_storage_service_impl.dart';

void main() {
  group('Dependency Injection Service', () {
    setUp(() {
      init(); // Initialize your DI service
    });

    tearDown(() {
      GetIt.I.reset(); // Reset GetIt instance after each test
    });

    test('All dependencies are registered', () {
      // Verify dependencies for Weather feature
      expect(GetIt.I<WeatherCubit>(), isNotNull);
      expect(GetIt.I<WeatherUsecase>(), isNotNull);
      expect(GetIt.I<CacheWeatherUsecase>(), isNotNull);
      expect(GetIt.I<OfflineWeatherUsecase>(), isNotNull);

      // Verify dependencies for Forecast feature
      expect(GetIt.I<ForecastCubit>(), isNotNull);
      expect(GetIt.I<ForecastUsecase>(), isNotNull);
      expect(GetIt.I<CacheForecastUseCase>(), isNotNull);
      expect(GetIt.I<OfflineForecastUsecase>(), isNotNull);

      // Verify connectivity adapter
      expect(GetIt.I<ConnectivityService>(), isA<ConnectivityServiceImpl>());

      // Verify repositories
      expect(GetIt.I<WeatherLocalRepository>(), isNotNull);
      expect(GetIt.I<ForecastLocalRepository>(), isNotNull);
      expect(GetIt.I<ForecastRemoteRepository>(), isNotNull);
      expect(GetIt.I<WeatherRemoteRepository>(), isNotNull);

      // Verify datasources
      expect(GetIt.I<WeatherLocalDatasource>(), isNotNull);
      expect(GetIt.I<ForecastLocalDatasource>(), isNotNull);
      expect(GetIt.I<WeatherRemoteDatasource>(), isNotNull);
      expect(GetIt.I<ForecastRemoteDatasource>(), isNotNull);

      // Verify other dependencies
      expect(GetIt.I<LocalStorageAdapter>(), isA<HiveLocalStorageAdapter>());
      expect(GetIt.I<http.Client>(), isNotNull);
    });
  });
}
