import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';

void main() {
  group('WeatherModel', () {
    test('fromJson should parse JSON correctly', () {
      // Arrange
      final json = {
        "coord": {"lat": 51.51, "lon": -0.13},
        "weather": [
          {
            "main": "Clear",
            "description": "clear sky",
            "icon": "01d",
          }
        ],
        "main": {
          "temp": 283.0,
          "pressure": 1015,
          "humidity": 70,
        }
      };

      // Act
      final weatherModel = WeatherModel.fromJson(json);

      // Assert
      expect(weatherModel.lat, equals(51.51));
      expect(weatherModel.lon, equals(-0.13));
      expect(weatherModel.main, equals("Clear"));
      expect(weatherModel.description, equals("clear sky"));
      expect(weatherModel.iconCode, equals("01d"));
      expect(weatherModel.temperature, equals(283));
      expect(weatherModel.pressure, equals(1015));
      expect(weatherModel.humidity, equals(70));
    });
  });
}
