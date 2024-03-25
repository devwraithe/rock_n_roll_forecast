import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final double lon, lat, wind, feelsLike;
  final String main;
  final String description;
  final String iconCode;
  final int temperature, humidity;

  const WeatherEntity({
    required this.lon,
    required this.lat,
    required this.wind,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.humidity,
    required this.feelsLike,
  });

  @override
  List<Object> get props => [
        lon,
        lat,
        wind,
        main,
        description,
        iconCode,
        temperature,
        humidity,
        feelsLike,
      ];
}
