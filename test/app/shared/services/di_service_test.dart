import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/forecast_local_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/weather_local_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/remote_datasources/forecast_remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/remote_datasources/weather_remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/forecast_repository.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/shared/services/connectivity_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/di_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/hive_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/http_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/local_storage_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/location_service.dart';

void main() {
  setUp(() => init()); // Initialize your DI service

  tearDown(() => GetIt.I.reset()); // Reset GetIt instance after each test

  test('All dependencies are registered', () {
    // Cubits
    expect(GetIt.I<WeatherCubit>(), isNotNull);
    expect(GetIt.I<ForecastCubit>(), isNotNull);

    // Usecases
    expect(GetIt.I<WeatherUsecase>(), isNotNull);
    expect(GetIt.I<ForecastUsecase>(), isNotNull);

    // Repositories
    expect(GetIt.I<WeatherRepository>(), isNotNull);
    expect(GetIt.I<ForecastRepository>(), isNotNull);

    // Datasources
    expect(GetIt.I<WeatherLocalDatasource>(), isNotNull);
    expect(GetIt.I<ForecastLocalDatasource>(), isNotNull);
    expect(GetIt.I<WeatherRemoteDatasource>(), isNotNull);
    expect(GetIt.I<ForecastRemoteDatasource>(), isNotNull);

    // Services
    expect(GetIt.I<ConnectivityService>(), isA<ConnectivityServiceImpl>());
    expect(GetIt.I<HiveService>(), isA<HiveServiceImpl>());
    expect(GetIt.I<LocationService>(), isA<LocationServiceImpl>());
    expect(GetIt.I<LocalStorageService>(), isA<LocalStorageServiceImpl>());
    expect(GetIt.I<HttpService>(), isA<HttpServiceImpl>());

    // Http client
    expect(GetIt.I<http.Client>(), isNotNull);
  });
}
