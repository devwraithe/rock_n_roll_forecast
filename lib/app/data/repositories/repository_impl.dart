import 'package:dartz/dartz.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/data/datasources/remote_datasource.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/current_weather_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';

import '../../core/utilities/errors/failure.dart';
import '../../domain/repositories/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDatasource datasource;
  RepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, CurrentWeatherEntity>> getCurrentWeather(
      String lat, String lon) async {
    try {
      final result = await datasource.getCurrentWeather(lat, lon);
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
      final result = await datasource.fiveDaysForecast(lat, lon);
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
