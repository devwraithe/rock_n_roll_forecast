import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/errors/failure.dart';
import '../../../domain/entities/forecast_entity.dart';
import '../../../domain/usecases/forecast_usecase.dart';
import 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final ForecastUsecase _usecase;

  ForecastCubit(this._usecase) : super(ForecastInitial());

  Future<void> getForecast(String city) async {
    emit(ForecastLoading());

    try {
      final result = await _usecase.execute(city);
      _emitForecastState(result);
    } catch (error) {
      emit(ForecastError(error.toString()));
    }
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
