import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/five_days_forecase_usecase.dart';
import 'five_days_forecast_state.dart';

class FiveDaysForecastCubit extends Cubit<FiveDaysForecastState> {
  final FiveDaysForecastUsecase _currentWeatherUsecase;

  FiveDaysForecastCubit(this._currentWeatherUsecase)
      : super(FiveDaysForecastInitial());

  Future<void> getFiveDaysForecast(String lat, String lon) async {
    emit(FiveDaysForecastLoading());

    try {
      final result = await _currentWeatherUsecase.execute(lat, lon);

      emit(
        result.fold(
          (failure) => FiveDaysForecastError(failure.message),
          (result) => FiveDaysForecastLoaded(result),
        ),
      );
    } catch (error) {
      emit(FiveDaysForecastError(error.toString()));
    }
  }
}
