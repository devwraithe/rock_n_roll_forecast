import 'package:equatable/equatable.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/current_weather_entity.dart';

abstract class CurrentWeatherStates extends Equatable {
  const CurrentWeatherStates();
  @override
  List<Object> get props => [];
}

class CurrentWeatherInitial extends CurrentWeatherStates {}

class CurrentWeatherLoading extends CurrentWeatherStates {}

class CurrentWeatherLoaded extends CurrentWeatherStates {
  final CurrentWeatherEntity result;
  const CurrentWeatherLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class CurrentWeatherError extends CurrentWeatherStates {
  final String message;
  const CurrentWeatherError(this.message);

  @override
  List<Object> get props => [message];
}
