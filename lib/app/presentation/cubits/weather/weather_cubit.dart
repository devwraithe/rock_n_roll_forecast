import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import '../../../domain/usecases/local_usecases/cache_weather_usecase.dart';
import '../../../domain/usecases/local_usecases/offline_weather_usecase.dart';
import '../../../domain/usecases/remote_usecases/weather_usecase.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  final WeatherUsecase _getWeatherUsecase;
  final CacheWeatherUsecase _cacheWeatherUsecase;
  final OfflineWeatherUsecase _offlineWeatherUsecase;
  final ConnectivityAdapter _connectivityAdapter;

  WeatherCubit(
    this._getWeatherUsecase,
    this._cacheWeatherUsecase,
    this._offlineWeatherUsecase,
    this._connectivityAdapter,
  ) : super(WeatherInitial());

  Future<void> getWeather(String lat, String lon, String city) async {
    emit(WeatherLoading());

    try {
      final hasInternet = await _connectivityAdapter.isConnected();

      if (hasInternet) {
        debugPrint("Internet connection is available!");
        final result = await _getWeatherUsecase.execute(lat, lon);

        emit(
          result.fold(
            (failure) => WeatherError(failure.message),
            (result) {
              _cacheWeatherUsecase.execute(result, city);
              return WeatherLoaded(result);
            },
          ),
        );
      } else {
        debugPrint("Internet connection is unavailable!");
        final result = await _offlineWeatherUsecase.execute(city);

        emit(
          result.fold(
            (failure) => WeatherError(failure.message),
            (result) => WeatherLoaded(result!),
          ),
        );
      }
    } catch (error) {
      emit(WeatherError(error.toString()));
    }
  }
}
