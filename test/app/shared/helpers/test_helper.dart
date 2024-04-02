import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/forecast_local_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/local_datasource/weather_local_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/remote_datasources/forecast_remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/datasources/remote_datasources/weather_remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/forecast_model.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/repositories/forecast_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/repositories/weather_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/location_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/forecast_repository.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/repositories/weather_repository.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/forecast_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/usecases/weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/concerts_list.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/shared/services/connectivity_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/hive_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/http_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/local_storage_service.dart';
import 'package:rock_n_roll_forecast/app/shared/services/location_service.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/env_config.dart';

@GenerateMocks([
  // Widgets
  ConcertsList,

  // Cubits
  WeatherCubit,
  ForecastCubit,

  // Usecases
  ForecastUsecaseImpl,
  WeatherUsecaseImpl,
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

  // Repositories
  ForecastRepositoryImpl,
  WeatherRepositoryImpl,
  WeatherRepository,
  ForecastRepository,

  // Remote Datasources
  WeatherRemoteDatasourceImpl,
  ForecastRemoteDatasourceImpl,
  WeatherRemoteDatasource,
  ForecastRemoteDatasource,

  // Exceptions
  CacheException,

  // Services
  ConnectivityService,
  HiveService,
  HttpService,
  LocalStorageService,
  LocationService,

  // Utilities
  EnvConfig,

  // Misc
  Client,
  Box,
  MethodChannel,
  HiveInterface,
  BuildContext,
  Connectivity,
  NavigatorObserver,
  RouteSettings,
])
void main() {}
