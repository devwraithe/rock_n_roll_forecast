import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_plus_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/local_storage_adapter/local_storage_adapter.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/remote_usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/remote_usecases/weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/five_days_forecast/five_days_forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';

import '../../data/datasources/remote_datasources/remote_datasource.dart';
import '../../data/datasources/remote_datasources/remote_datasource_impl.dart';
import '../../data/repositories/local_repository_impl.dart';
import '../../data/repositories/remote_repository_impl.dart';
import '../../domain/repositories/remote_repository.dart';
import '../../domain/usecases/local_usecases/cache_forecast_usecase.dart';
import '../../domain/usecases/local_usecases/cache_weather_usecase.dart';
import '../../domain/usecases/local_usecases/offline_forecast_usecase.dart';
import '../../domain/usecases/local_usecases/offline_weather_usecase.dart';
import 'adapters/local_storage_adapter/hive_local_storage_adapter.dart';

final sl = GetIt.instance; // the service locator(sl)

void regFactory<T extends Object>(T Function() factFunc) {
  sl.registerFactory(factFunc);
}

void regSingleton<T extends Object>(T Function() factFunc) {
  sl.registerLazySingleton(factFunc);
}

void init() {
  // can have a separate methods as app scales
  regSingleton(() => WeatherCubit(sl(), sl(), sl(), sl()));
  regSingleton(() => WeatherUsecase(sl()));
  regSingleton(() => CacheWeatherUsecase(sl()));
  regSingleton(() => OfflineWeatherUsecase(sl()));

  // can have a separate methods as app scales
  regSingleton(() => ForecastCubit(sl(), sl(), sl(), sl()));
  regSingleton(() => ForecastUsecase(sl()));
  regSingleton(() => CacheForecastUsecase(sl()));
  regSingleton(() => OfflineForecastUsecase(sl()));

  regSingleton<ConnectivityAdapter>(
    () => ConnectivityPlusAdapter(Connectivity()),
  );
  // regSingleton(() => Connectivity());

  regSingleton<LocalRepository>(() => LocalRepositoryImpl(sl()));
  regSingleton<RemoteRepository>(() => RemoteRepositoryImpl(sl()));

  regSingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));
  regSingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl()));

  regSingleton<LocalStorageAdapter>(() => HiveLocalStorageAdapter());
  regSingleton(() => http.Client());
}
