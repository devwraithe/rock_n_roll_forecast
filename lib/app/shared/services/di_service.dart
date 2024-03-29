import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/shared/services/http_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/location_service.dart';

import '../../modules/weather/data/datasources/local_datasource/forecast_local_datasource.dart';
import '../../modules/weather/data/datasources/local_datasource/weather_local_datasource.dart';
import '../../modules/weather/data/datasources/remote_datasources/forecast_remote_datasource.dart';
import '../../modules/weather/data/datasources/remote_datasources/weather_remote_datasource.dart';
import '../../modules/weather/data/repositories/forecast_repository_impl.dart';
import '../../modules/weather/data/repositories/weather_repository_impl.dart';
import '../../modules/weather/domain/repositories/forecast_repository.dart';
import '../../modules/weather/domain/repositories/weather_repository.dart';
import '../../modules/weather/domain/usecases/weather_usecase.dart';
import '../../modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'connectivity_service.dart';
import 'hive_service.dart';
import 'local_storage_service.dart';

// Service locator(sl)
final sl = GetIt.instance;

void regFactory<T extends Object>(T Function() factFunc) {
  sl.registerFactory(factFunc);
}

void regSingleton<T extends Object>(T Function() factFunc) {
  sl.registerLazySingleton(factFunc);
}

Future<void> init() async {
  // Cubits
  regSingleton<WeatherCubit>(
    () => WeatherCubit(sl()),
  );
  regSingleton<ForecastCubit>(
    () => ForecastCubit(sl()),
  );

  // Usecases
  regSingleton<WeatherUsecase>(
    () => WeatherUsecaseImpl(sl()),
  );
  regSingleton<ForecastUsecase>(
    () => ForecastUsecaseImpl(sl()),
  );

  // Repositories
  regSingleton<ForecastRepository>(
    () => ForecastRepositoryImpl(sl(), sl(), sl()),
  );
  regSingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl(), sl(), sl()),
  );

  // Datasources
  regSingleton<WeatherLocalDatasource>(
    () => WeatherLocalDatasourceImpl(sl()),
  );
  regSingleton<ForecastLocalDatasource>(
    () => ForecastLocalDatasourceImpl(sl()),
  );
  regSingleton<WeatherRemoteDatasource>(
    () => WeatherRemoteDatasourceImpl(sl(), sl(), sl()),
  );
  regSingleton<ForecastRemoteDatasource>(
    () => ForecastRemoteDatasourceImpl(sl(), sl(), sl()),
  );

  // Services
  regSingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(Connectivity()),
  );
  regSingleton<HiveService>(
    () => HiveServiceImpl(),
  );
  regSingleton<LocationService>(
    () => const LocationServiceImpl(),
  );
  regSingleton<LocalStorageService>(
    () => LocalStorageServiceImpl(sl()),
  );
  regSingleton<HttpService>(
    () => HttpServiceImpl(),
  );

  // Http client
  regSingleton(
    () => http.Client(),
  );
}
