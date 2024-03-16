import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/adapters/local_storage_adapter/local_storage_adapter.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/location_helper.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/misc_helper.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/local_datasource/local_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasources/remote_datasource_impl.dart';
import 'package:rock_n_roll_forecast/app/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/data/repositories/local_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/data/repositories/remote_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/location_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/local_repository.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/remote_repository.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/cache_forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/cache_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/offline_forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local_usecases/offline_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/remote_usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/remote_usecases/weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concerts_list.dart';

@GenerateMocks([
  // Widgets
  ConcertsList,

  // Cubits
  WeatherCubit,
  ForecastCubit,

  // Usecases
  CacheForecastUseCaseImpl,
  CacheWeatherUsecaseImpl,
  OfflineForecastUsecaseImpl,
  OfflineWeatherUsecaseImpl,
  ForecastUsecaseImpl,
  WeatherUsecaseImpl,
  CacheForecastUseCase,
  CacheWeatherUsecase,
  OfflineForecastUsecase,
  OfflineWeatherUsecase,
  ForecastUsecase,
  WeatherUsecase,

  // Entities
  WeatherEntity,
  ForecastEntity,
  LocationEntity,

  // Models
  WeatherModel,
  ForecastModel,

  // Local Datasources
  WeatherLocalDatasourceImpl,
  ForecastLocalDatasourceImpl,
  WeatherLocalDatasource,
  ForecastLocalDatasource,

  // Local Repositories
  ForecastLocalRepositoryImpl,
  WeatherLocalRepositoryImpl,
  ForecastLocalRepository,
  WeatherLocalRepository,

  // Remote Repositories
  WeatherRemoteRepositoryImpl,
  ForecastRemoteRepositoryImpl,
  WeatherRemoteRepository,
  ForecastRemoteRepository,

  // Remote Datasources
  WeatherRemoteDatasourceImpl,
  ForecastRemoteDatasourceImpl,
  WeatherRemoteDatasource,
  ForecastRemoteDatasource,

  // Exceptions
  CacheException,

  // Miscellaneous
  ConnectivityAdapter,
  LocalStorageAdapter,
  Client,
  Box,
  MethodChannel,
  HiveInterface,
  MiscHelper,
  LocationHelper,
  BuildContext,
  Connectivity,
  NavigatorObserver,
  RouteSettings,
])
void main() {}
