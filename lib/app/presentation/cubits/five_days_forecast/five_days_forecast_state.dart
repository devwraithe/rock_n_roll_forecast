import 'package:equatable/equatable.dart';

import '../../../domain/entities/daily_forecast_entity.dart';

abstract class FiveDaysForecastState extends Equatable {
  const FiveDaysForecastState();
  @override
  List<Object> get props => [];
}

class FiveDaysForecastInitial extends FiveDaysForecastState {}

class FiveDaysForecastLoading extends FiveDaysForecastState {}

class FiveDaysForecastLoaded extends FiveDaysForecastState {
  final List<DailyForecastEntity> result;
  const FiveDaysForecastLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class FiveDaysForecastError extends FiveDaysForecastState {
  final String message;
  const FiveDaysForecastError(this.message);

  @override
  List<Object> get props => [message];
}
