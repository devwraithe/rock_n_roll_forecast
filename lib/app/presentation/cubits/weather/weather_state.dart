import 'package:equatable/equatable.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

abstract class WeatherStates extends Equatable {
  const WeatherStates();
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherStates {}

class WeatherLoading extends WeatherStates {}

class WeatherLoaded extends WeatherStates {
  final WeatherEntity result;
  const WeatherLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WeatherError extends WeatherStates {
  final String message;
  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
