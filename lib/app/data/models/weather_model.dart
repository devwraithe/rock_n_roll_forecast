import 'package:equatable/equatable.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherModel extends Equatable {
  final num lon, lat;
  final String main, description, iconCode;
  final int temperature, pressure, humidity;

  const WeatherModel({
    required this.lon,
    required this.lat,
    required this.main,
    required this.description,
    required this.iconCode,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      lat: json['coord']["lat"],
      lon: json['coord']["lon"],
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      temperature: json['main']['temp'].round(),
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
    );
  }

  WeatherEntity toEntity() {
    return WeatherEntity(
      lat: lat,
      lon: lon,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      pressure: pressure,
      humidity: humidity,
    );
  }

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
