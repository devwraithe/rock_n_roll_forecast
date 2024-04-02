import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/weather_entity.dart';

void main() {
  test('Should initialize with the correct values', () {
    const lon = 100.0;
    const lat = 50.0;
    const main = 'Cloudy';
    const description = 'Partly cloudy';
    const iconCode = '03d';
    const temperature = 25;
    const feelsLike = 25.0;
    const wind = 2.0;
    const humidity = 70;

    const weatherEntity = WeatherEntity(
      lon: lon,
      lat: lat,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      wind: wind,
      humidity: humidity,
      feelsLike: feelsLike,
    );

    expect(weatherEntity.lon, lon);
    expect(weatherEntity.lat, lat);
    expect(weatherEntity.main, main);
    expect(weatherEntity.description, description);
    expect(weatherEntity.iconCode, iconCode);
    expect(weatherEntity.temperature, temperature);
    expect(weatherEntity.feelsLike, feelsLike);
    expect(weatherEntity.wind, wind);
    expect(weatherEntity.humidity, humidity);
  });

  test('Should be equal if their properties match', () {
    const lon = 100.0;
    const lat = 50.0;
    const main = 'Cloudy';
    const description = 'Partly cloudy';
    const iconCode = '03d';
    const temperature = 25;
    const feelsLike = 25.0;
    const wind = 2.0;
    const humidity = 70;

    const weatherEntity1 = WeatherEntity(
      lon: lon,
      lat: lat,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      feelsLike: feelsLike,
      wind: wind,
      humidity: humidity,
    );

    const weatherEntity2 = WeatherEntity(
      lon: lon,
      lat: lat,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      feelsLike: feelsLike,
      wind: wind,
      humidity: humidity,
    );

    expect(weatherEntity1, equals(weatherEntity2));
  });

  test('Should not be equal if their properties do not match', () {
    const lon1 = 100.0;
    const lat1 = 50.0;
    const main1 = 'Cloudy';
    const description1 = 'Partly cloudy';
    const iconCode1 = '03d';
    const temperature1 = 25;
    const feelsLike1 = 25.0;
    const wind1 = 2.0;
    const humidity1 = 70;

    const lon2 = 150.0;
    const lat2 = 50.0;
    const main2 = 'Sunny';
    const description2 = 'Clear sky';
    const iconCode2 = '01d';
    const temperature2 = 30;
    const feelsLike2 = 30.0;
    const wind2 = 4.0;
    const humidity2 = 75;

    const weatherEntity1 = WeatherEntity(
      lon: lon1,
      lat: lat1,
      main: main1,
      description: description1,
      iconCode: iconCode1,
      temperature: temperature1,
      feelsLike: feelsLike1,
      wind: wind1,
      humidity: humidity1,
    );

    const weatherEntity2 = WeatherEntity(
      lon: lon2,
      lat: lat2,
      main: main2,
      description: description2,
      iconCode: iconCode2,
      temperature: temperature2,
      feelsLike: feelsLike2,
      wind: wind2,
      humidity: humidity2,
    );

    expect(weatherEntity1, isNot(equals(weatherEntity2)));
  });
}
