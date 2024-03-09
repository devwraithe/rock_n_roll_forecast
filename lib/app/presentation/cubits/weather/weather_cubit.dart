import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utilities/adapters/connectivity_adapter/connectivity_adapter.dart';
import '../../../core/utilities/errors/failure.dart';
import '../../../domain/entities/weather_entity.dart';
import '../../../domain/usecases/local_usecases/cache_weather_usecase.dart';
import '../../../domain/usecases/local_usecases/offline_weather_usecase.dart';
import '../../../domain/usecases/remote_usecases/weather_usecase.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
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
        final result = await _getWeatherUsecase.execute(lat, lon);
        _cacheWeather(result, city);
      } else {
        final result = await _offlineWeatherUsecase.execute(city);
        _emitWeatherState(result);
      }
    } catch (error) {
      emit(WeatherError(error.toString()));
    }
  }

  void _cacheWeather(Either<Failure, WeatherEntity> result, String city) async {
    _emitWeatherState(result);

    result.fold(
      (failure) => WeatherError(failure.message), // Handle failure silently
      (weather) => _cacheWeatherUsecase.execute(weather, city),
    );
  }

  void _emitWeatherState(Either<Failure, WeatherEntity?> result) {
    emit(
      result.fold(
        (failure) => WeatherError(failure.message),
        (weather) => WeatherLoaded(weather!),
      ),
    );
  }
}
