import 'package:dartz/dartz.dart';

import '../../../../shared/errors/exceptions.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/services/connectivity_service.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/local_datasource/weather_local_datasource.dart';
import '../datasources/remote_datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDatasource remoteDatasource;
  final WeatherLocalDatasource _localDatasource;
  final ConnectivityService connectivityService;

  WeatherRepositoryImpl(
    this.remoteDatasource,
    this._localDatasource,
    this.connectivityService,
  );

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String city) async {
    try {
      if (await connectivityService.isConnected()) {
        final result = await remoteDatasource.getWeather(city);
        final weatherEntity = result.toEntity();
        await _localDatasource.cacheWeather(weatherEntity, city);
        return Right(weatherEntity);
      } else {
        final result = await _localDatasource.offlineWeather(city);
        return Right(result);
      }
    } on ServerException catch (e) {
      return Left(e.failure);
    } on NetworkException catch (e) {
      return Left(e.failure);
    } on HttpException catch (e) {
      return Left(e.failure);
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
