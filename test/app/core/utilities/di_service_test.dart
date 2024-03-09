import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/local_storage_adapter/local_storage_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/di_service.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/remote_repository.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';

// Import other dependencies as needed

void main() {
  test('Service locator initialization test', () {
    // Initialize the service locator
    init();

    // Verify if the necessary dependencies are registered correctly
    final sl = GetIt.instance;

    // Verify registration of factories
    expect(sl.isRegistered<WeatherCubit>(), true);
    expect(sl.isRegistered<ForecastCubit>(), true);

    // Verify registration of singletons
    expect(sl.isRegistered<ConnectivityAdapter>(), true);
    expect(sl.isRegistered<WeatherLocalRepository>(), true);
    expect(sl.isRegistered<ForecastLocalRepository>(), true);
    expect(sl.isRegistered<ForecastRemoteRepository>(), true);
    expect(sl.isRegistered<WeatherRemoteRepository>(), true);
    expect(sl.isRegistered<WeatherLocalDatasource>(), true);
    expect(sl.isRegistered<WeatherLocalDatasourceImpl>(), false);
    expect(sl.isRegistered<ForecastLocalDatasource>(), true);
    expect(sl.isRegistered<ForecastLocalDatasourceImpl>(), false);
    expect(sl.isRegistered<WeatherRemoteDatasource>(), true);
    expect(sl.isRegistered<WeatherRemoteDatasourceImpl>(), false);
    expect(sl.isRegistered<ForecastRemoteDatasource>(), true);
    expect(sl.isRegistered<WeatherRemoteDatasourceImpl>(), false);
    expect(sl.isRegistered<LocalStorageAdapter>(), true);
  });
}
