import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/remote_repository.dart';

import '../../core/utilities/errors/failure.dart';
import '../datasources/remote_datasources/remote_datasource.dart';

class RemoteRepositoryImpl implements RemoteRepository {
  final RemoteDatasource remoteDatasource;

  RemoteRepositoryImpl(this.remoteDatasource);

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

  @override
  Future<Either<Failure, List<ForecastEntity>>> getForecast(
    String lat,
    String lon,
  ) async {
    try {
      final result = await remoteDatasource.forecast(lat, lon);
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
