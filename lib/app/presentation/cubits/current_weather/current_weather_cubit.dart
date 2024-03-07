import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local/cache_current_weather_usecase.dart';
import 'package:rock_n_roll_forecast/app/domain/usecases/local/get_cached_weather_usecase.dart';

import '../../../domain/usecases/get_current_weather_usecase.dart';
import 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherStates> {
  final GetCurrentWeatherUsecase _currentWeatherUsecase;
  final CacheCurrentWeatherUsecase _cacheCurrentWeatherUsecase;
  final GetCachedWeatherUsecase _cachedWeatherUsecase;
  final Connectivity connectivity;

  CurrentWeatherCubit(
    this._currentWeatherUsecase,
    this._cacheCurrentWeatherUsecase,
    this.connectivity,
    this._cachedWeatherUsecase,
  ) : super(CurrentWeatherInitial());

  Future<void> getCurrentWeather({
    String? lat,
    String? lon,
  }) async {
    final cityName = "Silvertone, UK";

    emit(CurrentWeatherLoading());

    try {
      final connectivityResult = await connectivity.checkConnectivity();
      final hasInternet = connectivityResult != ConnectivityResult.none;

      if (hasInternet) {
        debugPrint("Internet connection is currently up and running!");
        final result = await _currentWeatherUsecase.execute(lat!, lon!);

        emit(
          result.fold(
            (failure) => CurrentWeatherError(failure.message),
            (result) {
              _cacheCurrentWeatherUsecase.execute(result, cityName);
              return CurrentWeatherLoaded(result);
            },
          ),
        );
      } else {
        debugPrint("Internet is currently unavailable!");
        final result = await _cachedWeatherUsecase.execute("Silverstone");
        debugPrint("After awaiting cached data");
        emit(
          result.fold((failure) {
            debugPrint("Error on cubit - $failure");
            return CurrentWeatherError(failure.message);
          }, (result) {
            debugPrint("Success on cubit - $result");
            return CurrentWeatherLoaded(result!);
          }),
        );
      }
    } catch (error) {
      emit(CurrentWeatherError(error.toString()));
    }
  }
}
