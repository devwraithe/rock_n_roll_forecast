import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/five_days_forecase_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/get_current_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local/cache_current_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local/get_cached_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/current_weather/current_weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/five_days_forecast/five_days_forecast_cubit.dart';

import '../../data/datasources/remote_datasource.dart';
import '../../data/repositories/repository_impl.dart';
import '../../domain/repositories/repository.dart';

final sl = GetIt.instance; // the service locator(sl)

void regFactory<T extends Object>(T Function() factFunc) {
  sl.registerFactory(factFunc);
}

void regSingleton<T extends Object>(T Function() factFunc) {
  sl.registerLazySingleton(factFunc);
}

void init() {
  // can have a separate methods as app scales
  regSingleton(() => CurrentWeatherCubit(sl(), sl(), sl(), sl()));
  regSingleton(() => GetCurrentWeatherUsecase(sl()));
  regSingleton(() => CacheCurrentWeatherUsecase(sl()));
  regSingleton(() => GetCachedWeatherUsecase(sl()));

  regSingleton<Connectivity>(() => Connectivity());

  // can have a separate methods as app scales
  regSingleton(() => FiveDaysForecastCubit(sl()));
  regSingleton(() => FiveDaysForecastUsecase(sl()));

  regSingleton<Repository>(() => RepositoryImpl(sl(), sl()));

  regSingleton<LocalDatasource>(() => LocalDatasourceImpl(sl()));
  regSingleton<RemoteDatasource>(() => RemoteDatasourceImpl(sl()));

  regSingleton<HiveInterface>(() => Hive);
  regSingleton(() => http.Client());
}
