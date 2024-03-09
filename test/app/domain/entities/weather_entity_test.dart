import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';

void main() {
  group('WeatherEntity', () {
    test('should initialize with the correct values', () {
      // Arrange
      const lon = 100.0;
      const lat = 50.0;
      const main = 'Cloudy';
      const description = 'Partly cloudy';
      const iconCode = '03d';
      const temperature = 25;
      const pressure = 1013;
      const humidity = 70;

      // Act
      final weatherEntity = WeatherEntity(
        lon: lon,
        lat: lat,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );

      // Assert
      expect(weatherEntity.lon, lon);
      expect(weatherEntity.lat, lat);
      expect(weatherEntity.main, main);
      expect(weatherEntity.description, description);
      expect(weatherEntity.iconCode, iconCode);
      expect(weatherEntity.temperature, temperature);
      expect(weatherEntity.pressure, pressure);
      expect(weatherEntity.humidity, humidity);
    });

    test('should be equal if their properties match', () {
      // Arrange
      const lon = 100.0;
      const lat = 50.0;
      const main = 'Cloudy';
      const description = 'Partly cloudy';
      const iconCode = '03d';
      const temperature = 25;
      const pressure = 1013;
      const humidity = 70;

      final weatherEntity1 = WeatherEntity(
        lon: lon,
        lat: lat,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );

      final weatherEntity2 = WeatherEntity(
        lon: lon,
        lat: lat,
        main: main,
        description: description,
        iconCode: iconCode,
        temperature: temperature,
        pressure: pressure,
        humidity: humidity,
      );

      // Act & Assert
      expect(weatherEntity1, equals(weatherEntity2));
    });

    test('should not be equal if their properties do not match', () {
      // Arrange
      const lon1 = 100.0;
      const lat1 = 50.0;
      const main1 = 'Cloudy';
      const description1 = 'Partly cloudy';
      const iconCode1 = '03d';
      const temperature1 = 25;
      const pressure1 = 1013;
      const humidity1 = 70;

      const lon2 = 150.0; // Different value
      const lat2 = 50.0;
      const main2 = 'Sunny';
      const description2 = 'Clear sky';
      const iconCode2 = '01d';
      const temperature2 = 30; // Different value
      const pressure2 = 1015;
      const humidity2 = 75; // Different value

      final weatherEntity1 = WeatherEntity(
        lon: lon1,
        lat: lat1,
        main: main1,
        description: description1,
        iconCode: iconCode1,
        temperature: temperature1,
        pressure: pressure1,
        humidity: humidity1,
      );

      final weatherEntity2 = WeatherEntity(
        lon: lon2,
        lat: lat2,
        main: main2,
        description: description2,
        iconCode: iconCode2,
        temperature: temperature2,
        pressure: pressure2,
        humidity: humidity2,
      );

      // Act & Assert
      expect(weatherEntity1, isNot(equals(weatherEntity2)));
    });
  });
}
