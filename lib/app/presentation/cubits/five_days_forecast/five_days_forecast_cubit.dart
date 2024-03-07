import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/misc_helper.dart';

import '../../../domain/usecases/five_days_forecase_usecase.dart';
import '../../../domain/usecases/local/cache_forecast_usecase.dart';
import '../../../domain/usecases/local/offline_forecast_usecase.dart';
import 'five_days_forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final ForecastUsecase _forecastUsecase;
  final CacheForecastUsecase _cacheForecastUsecase;
  final OfflineForecastUsecase _offlineForecastUsecase;
  final Connectivity connectivity;

  ForecastCubit(
    this._forecastUsecase,
    this._cacheForecastUsecase,
    this._offlineForecastUsecase,
    this.connectivity,
  ) : super(ForecastInitial());

  Future<void> getForecast(String lat, String lon, String city) async {
    emit(ForecastLoading());

    try {
      if (await MiscHelper.hasInternetConnection() == true) {
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
