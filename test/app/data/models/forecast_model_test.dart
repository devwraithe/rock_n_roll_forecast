import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/data/models/forecast_model.dart';

void main() {
  group('ForecastModel', () {
    test('fromJson should parse JSON correctly', () {
      // Arrange
      final json = {
        "dt": 1615377600,
        "main": {
          "temp_min": 20,
          "temp_max": 30,
        },
        "weather": [
          {"icon": "01d"}
        ]
      };

      // Act
      final forecastModel = ForecastModel.fromJson(json);

      // Assert
      expect(forecastModel.dailyTime, equals(1615377600));
      expect(forecastModel.dailyMinTemp, equals(20));
      expect(forecastModel.dailyMaxTemp, equals(30));
      expect(forecastModel.dailyIcon, equals("01d"));
    });
  });
}
