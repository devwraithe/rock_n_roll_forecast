import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/errors/failure.dart';
import '../../../core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import '../../../domain/entities/forecast_entity.dart';
import '../../../domain/usecases/local_usecases/cache_forecast_usecase.dart';
import '../../../domain/usecases/local_usecases/offline_forecast_usecase.dart';
import '../../../domain/usecases/remote_usecases/forecast_usecase.dart';
import 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final ForecastUsecase _forecastUsecase;
  final CacheForecastUseCase _cacheForecastUsecase;
  final OfflineForecastUsecase _offlineForecastUsecase;
  final ConnectivityAdapter _connectivityAdapter;

  ForecastCubit(
    this._forecastUsecase,
    this._cacheForecastUsecase,
    this._offlineForecastUsecase,
    this._connectivityAdapter,
  ) : super(ForecastInitial());

  Future<void> getForecast(String lat, String lon, String city) async {
    emit(ForecastLoading());

    try {
      final hasInternet = await _connectivityAdapter.isConnected();

      if (hasInternet) {
        debugPrint("Internet connection is available!");
        final result = await _forecastUsecase.execute(lat, lon);
        _cacheForecast(result, city);
      } else {
        debugPrint("Internet connection is unavailable!");
        final result = await _offlineForecastUsecase.execute(city);
        _emitForecastState(result);
      }
    } catch (error) {
      emit(ForecastError(error.toString()));
    }
  }

  void _cacheForecast(
    Either<Failure, List<ForecastEntity>> result,
    String city,
  ) async {
    _emitForecastState(result);

    result.fold(
      (failure) => ForecastError(failure.message), // Handle failure silently
      (forecast) => _cacheForecastUsecase.execute(forecast, city),
    );
  }

  void _emitForecastState(Either<Failure, List<ForecastEntity>> result) {
    emit(
      result.fold(
        (failure) => ForecastError(failure.message),
        (forecast) => ForecastLoaded(forecast),
      ),
    );
  }
}
