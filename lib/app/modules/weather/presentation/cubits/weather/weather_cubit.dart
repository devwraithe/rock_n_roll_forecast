import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/weather/weather_state.dart';

import '../../../../../shared/errors/failure.dart';
import '../../../domain/entities/weather_entity.dart';
import '../../../domain/usecases/weather_usecase.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherUsecase _usecase;

  WeatherCubit(this._usecase) : super(WeatherInitial());

  Future<void> getWeather(String city) async {
    emit(WeatherLoading());

    try {
      final result = await _usecase.execute(city);
      _emitWeatherState(result);
    } catch (error) {
      emit(WeatherError(error.toString()));
    }
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
