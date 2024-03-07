import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import '../../../domain/usecases/local_usecases/cache_forecast_usecase.dart';
import '../../../domain/usecases/local_usecases/offline_forecast_usecase.dart';
import '../../../domain/usecases/remote_usecases/forecast_usecase.dart';
import 'five_days_forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final ForecastUsecase _forecastUsecase;
  final CacheForecastUsecase _cacheForecastUsecase;
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

        emit(
          result.fold(
            (failure) => ForecastError(failure.message),
            (result) {
              _cacheForecastUsecase.execute(result, city);
              return ForecastLoaded(result);
            },
          ),
        );
      } else {
        debugPrint("Internet connection is unavailable!");
        final result = await _offlineForecastUsecase.execute(city);

        emit(
          result.fold(
            (failure) => ForecastError(failure.message),
            (result) => ForecastLoaded(result),
          ),
        );
      }
    } catch (error) {
      emit(ForecastError(error.toString()));
    }
  }
}
