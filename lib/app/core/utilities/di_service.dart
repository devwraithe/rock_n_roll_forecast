import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_plus_adapter.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/five_days_forecase_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/get_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local/cache_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local/offline_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/five_days_forecast/five_days_forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';

import '../../data/datasources/remote_datasource.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repositories/repository.dart';
import '../../domain/usecases/local/cache_forecast_usecase.dart';
import '../../domain/usecases/local/offline_forecast_usecase.dart';

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

  regSingleton<ConnectivityAdapter>(() => ConnectivityPlusAdapter(sl()));
  regSingleton(() => Connectivity());

  regSingleton<Repository>(() => RepositoryImpl(sl(), sl()));

  regSingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));
  regSingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl()));

  regSingleton<HiveInterface>(() => Hive);
  regSingleton(() => http.Client());
}
