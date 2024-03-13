import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

import '../../core/utilities/errors/failure.dart';
import '../../domain/repositories/remote_repository.dart';
import '../datasources/remote_datasources/remote_datasource.dart';

class WeatherRemoteRepositoryImpl implements WeatherRemoteRepository {
  final WeatherRemoteDatasource remoteDatasource;
  WeatherRemoteRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(
    String lat,
    String lon,
  ) async {
    try {
      final result = await remoteDatasource.getWeather(lat, lon);
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

class ForecastRemoteRepositoryImpl implements ForecastRemoteRepository {
  final ForecastRemoteDatasource remoteDatasource;
  ForecastRemoteRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<ForecastEntity>>> getForecast(
    String lat,
    String lon,
  ) async {
    try {
      final result = await remoteDatasource.getForecast(lat, lon);
      return Right(result.map((f) => f.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
