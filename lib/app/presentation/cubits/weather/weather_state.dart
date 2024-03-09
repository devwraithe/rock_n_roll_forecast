import 'package:equatable/equatable.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity result;
  const WeatherLoaded(this.result);

  @override
  List<Object> get props => [result];
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}
