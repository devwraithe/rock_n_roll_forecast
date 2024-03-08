import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final num lon, lat;
  final String main;
  final String description;
  final String iconCode;
  final int temperature, pressure, humidity;

  const WeatherEntity({
    required this.lon,
    required this.lat,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  @override
  List<Object> get props => [
        lon,
        lat,
        main,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
      ];
}
