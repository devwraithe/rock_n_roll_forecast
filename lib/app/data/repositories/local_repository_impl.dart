import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/utilities/errors/failure.dart';
import '../../domain/repositories/local_repository.dart';
import '../datasources/local_datasource/local_datasource.dart';

class WeatherLocalRepositoryImpl implements WeatherLocalRepository {
  final WeatherLocalDatasource localDatasource;
  WeatherLocalRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, void>> cacheWeather(
    WeatherEntity weather,
    String city,
  ) async {
    try {
      await localDatasource.cacheWeather(weather, city);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(e.failure);
    } on HiveException catch (e) {
      return Left(e.failure);
    } on UnexpectedException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, WeatherEntity?>> offlineWeather(String city) async {
    try {
      final result = await localDatasource.offlineWeather(city);
      return Right(result);
    } on CacheException catch (e) {
      return Left(e.failure);
    } on HiveException catch (e) {
      return Left(e.failure);
    } on UnexpectedException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

class ForecastLocalRepositoryImpl implements ForecastLocalRepository {
  final ForecastLocalDatasource localDatasource;
  ForecastLocalRepositoryImpl(this.localDatasource);

  @override
  Future<Either<Failure, void>> cacheForecast(
    List<ForecastEntity> forecast,
    String city,
  ) async {
    try {
      await localDatasource.cacheForecast(forecast, city);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(e.failure);
    } on HiveException catch (e) {
      return Left(e.failure);
    } on UnexpectedException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ForecastEntity>>> offlineForecast(
    String city,
  ) async {
    try {
      final result = await localDatasource.offlineForecasts(city);
      return Right(result);
    } on CacheException catch (e) {
      return Left(e.failure);
    } on HiveException catch (e) {
      return Left(e.failure);
    } on UnexpectedException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
