import 'package:equatable/equatable.dart';

import '../../domain/entities/weather_entity.dart';

class WeatherModel extends Equatable {
  final num lon, lat, wind, feelsLike;
  final String main, description, iconCode;
  final int temperature, pressure, humidity;

  const WeatherModel({
    required this.lon,
    required this.lat,
    required this.wind,
    required this.feelsLike,
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
      wind: json['wind']['speed'],
      feelsLike: json['main']['feels_like'],
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
      wind: wind,
      feelsLike: feelsLike,
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
        wind,
        main,
        feelsLike,
        description,
        iconCode,
        temperature,
        pressure,
        humidity,
      ];
}
