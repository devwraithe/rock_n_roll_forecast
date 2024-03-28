import 'package:equatable/equatable.dart';

import '../../../domain/entities/forecast_entity.dart';

abstract class ForecastState extends Equatable {
  const ForecastState();
  @override
  List<Object> get props => [];
}

class ForecastInitial extends ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastLoaded extends ForecastState {
  final List<ForecastEntity> result;
  const ForecastLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class ForecastError extends ForecastState {
  final String message;
  const ForecastError(this.message);

  @override
  List<Object> get props => [message];
}
