import 'package:dartz/dartz.dart';

import '../../../../shared/errors/exceptions.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../shared/services/connectivity_service.dart';
import '../../domain/entities/forecast_entity.dart';
import '../../domain/repositories/forecast_repository.dart';
import '../datasources/local_datasource/forecast_local_datasource.dart';
import '../datasources/remote_datasources/forecast_remote_datasource.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastRemoteDatasource remoteDatasource;
  final ForecastLocalDatasource _localDatasource;
  final ConnectivityService connectivityService;

  ForecastRepositoryImpl(
    this.remoteDatasource,
    this._localDatasource,
    this.connectivityService,
  );

  @override
  Future<Either<Failure, List<ForecastEntity>>> getForecast(String city) async {
    try {
      if (await connectivityService.isConnected()) {
        final result = await remoteDatasource.getForecast(city);
        final forecastList = result.map((f) => f.toEntity()).toList();
        await _localDatasource.cacheForecast(forecastList, city);
        return Right(forecastList);
      } else {
        final result = await _localDatasource.offlineForecasts(city);
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
