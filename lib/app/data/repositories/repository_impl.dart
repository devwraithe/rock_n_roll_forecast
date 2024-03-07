import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/current_weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';

import '../../core/utilities/errors/failure.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/local_datasource.dart';

class RepositoryImpl implements Repository {
  final RemoteDatasource remoteDatasource;
  final LocalDatasource localDatasource;

  RepositoryImpl(this.remoteDatasource, this.localDatasource);

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
    String lat,
    String lon,
  ) async {
    try {
      final result = await remoteDatasource.getCurrentWeather(lat, lon);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DailyForecastEntity>>> fiveDaysForecast(
    String lat,
    String lon,
  ) async {
    try {
      final result = await remoteDatasource.fiveDaysForecast(lat, lon);
      return Right(result.map((f) => f.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> cacheCurrentWeather(
    CurrentWeatherEntity weather,
    String city,
  ) async {
    await localDatasource.cacheCurrentWeather(weather, city);
  }

  @override
  Future<Either<Failure, CurrentWeatherEntity?>> getCachedWeather(
    String city,
  ) async {
    try {
      final result = await localDatasource.getCachedCurrentWeather(city);
      return Right(result);
    } on CacheException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
