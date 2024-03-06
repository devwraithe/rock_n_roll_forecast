import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_current_weather_usecase.dart';
import 'current_weather_state.dart';

class CurrentWeatherCubit extends Cubit<CurrentWeatherStates> {
  final GetCurrentWeatherUsecase _currentWeatherUsecase;

  CurrentWeatherCubit(this._currentWeatherUsecase)
      : super(CurrentWeatherInitial());

  Future<void> getCurrentWeather(String lat, String lon) async {
    emit(CurrentWeatherLoading());

    try {
      final result = await _currentWeatherUsecase.execute(lat, lon);

      emit(
        result.fold(
          (failure) => CurrentWeatherError(failure.message),
          (result) => CurrentWeatherLoaded(result),
        ),
      );
    } catch (error) {
      emit(CurrentWeatherError(error.toString()));
    }
  }
}
