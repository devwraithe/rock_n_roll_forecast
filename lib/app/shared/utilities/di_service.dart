import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/local_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/remote_usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/remote_usecases/weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/adapters/connectivity_adapter/connectivity_plus_adapter.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/adapters/local_storage_adapter/local_storage_adapter.dart';

import '../../modules/weather/data/datasources/local_datasource/local_datasource.dart';
import '../../modules/weather/data/datasources/remote_datasources/remote_datasource.dart';
import '../../modules/weather/data/datasources/remote_datasources/remote_datasource_impl.dart';
import '../../modules/weather/data/repositories/local_repository_impl.dart';
import '../../modules/weather/data/repositories/remote_repository_impl.dart';
import '../../modules/weather/domain/repositories/local_repository.dart';
import '../../modules/weather/domain/repositories/remote_repository.dart';
import '../../modules/weather/domain/usecases/local_usecases/cache_forecast_usecase.dart';
import '../../modules/weather/domain/usecases/local_usecases/cache_weather_usecase.dart';
import '../../modules/weather/domain/usecases/local_usecases/offline_forecast_usecase.dart';
import '../../modules/weather/domain/usecases/local_usecases/offline_weather_usecase.dart';
import '../../modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'adapters/local_storage_adapter/local_storage_adapter_impl.dart';

final sl = GetIt.instance; // the service locator(sl)

void regFactory<T extends Object>(T Function() factFunc) {
  sl.registerFactory(factFunc);
}

void regSingleton<T extends Object>(T Function() factFunc) {
  sl.registerLazySingleton(factFunc);
}

void init() {
  // can have a separate methods as app scales
  regSingleton(
    () => WeatherCubit(sl(), sl(), sl(), sl()),
  );
  regSingleton<WeatherUsecase>(
    () => WeatherUsecaseImpl(sl()),
  );
  regSingleton<CacheWeatherUsecase>(
    () => CacheWeatherUsecaseImpl(sl()),
  );
  regSingleton<OfflineWeatherUsecase>(
    () => OfflineWeatherUsecaseImpl(sl()),
  );

  regSingleton(
    () => ForecastCubit(sl(), sl(), sl(), sl()),
  );
  regSingleton<ForecastUsecase>(
    () => ForecastUsecaseImpl(sl()),
  );
  regSingleton<CacheForecastUseCase>(
    () => CacheForecastUseCaseImpl(sl()),
  );
  regSingleton<OfflineForecastUsecase>(
    () => OfflineForecastUsecaseImpl(sl()),
  );

  regSingleton<ConnectivityAdapter>(
    () => ConnectivityPlusAdapter(Connectivity()),
  );

  regSingleton<WeatherLocalRepository>(
    () => WeatherLocalRepositoryImpl(sl()),
  );
  regSingleton<ForecastLocalRepository>(
    () => ForecastLocalRepositoryImpl(sl()),
  );
  regSingleton<ForecastRemoteRepository>(
    () => ForecastRemoteRepositoryImpl(sl()),
  );
  regSingleton<WeatherRemoteRepository>(
    () => WeatherRemoteRepositoryImpl(sl()),
  );

  regSingleton<WeatherLocalDatasource>(
    () => WeatherLocalDatasourceImpl(sl()),
  );
  regSingleton<ForecastLocalDatasource>(
    () => ForecastLocalDatasourceImpl(sl()),
  );
  regSingleton<WeatherRemoteDatasource>(
    () => WeatherRemoteDatasourceImpl(sl()),
  );
  regSingleton<ForecastRemoteDatasource>(
    () => ForecastRemoteDatasourceImpl(sl()),
  );
  regSingleton<LocalStorageAdapter>(
    () => HiveLocalStorageAdapter(),
  );
  regSingleton(
    () => http.Client(),
  );
}
