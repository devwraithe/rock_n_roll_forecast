import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';

void main() {
  group('ForecastEntity', () {
    test('should initialize with the correct values', () {
      // Arrange
      const dailyTime = 1625695200;
      const dailyMinTemp = 25.0;
      const dailyMaxTemp = 30.0;
      const dailyIcon = '01d';

      // Act
      final forecastEntity = ForecastEntity(
        dailyTime: dailyTime,
        dailyMinTemp: dailyMinTemp,
        dailyMaxTemp: dailyMaxTemp,
        dailyIcon: dailyIcon,
      );

      // Assert
      expect(forecastEntity.dailyTime, dailyTime);
      expect(forecastEntity.dailyMinTemp, dailyMinTemp);
      expect(forecastEntity.dailyMaxTemp, dailyMaxTemp);
      expect(forecastEntity.dailyIcon, dailyIcon);
    });

    test('should be equal if their properties match', () {
      // Arrange
      const dailyTime = 1625695200;
      const dailyMinTemp = 25.0;
      const dailyMaxTemp = 30.0;
      const dailyIcon = '01d';

      final forecastEntity1 = ForecastEntity(
        dailyTime: dailyTime,
        dailyMinTemp: dailyMinTemp,
        dailyMaxTemp: dailyMaxTemp,
        dailyIcon: dailyIcon,
      );

      final forecastEntity2 = ForecastEntity(
        dailyTime: dailyTime,
        dailyMinTemp: dailyMinTemp,
        dailyMaxTemp: dailyMaxTemp,
        dailyIcon: dailyIcon,
      );

      // Act & Assert
      expect(forecastEntity1, equals(forecastEntity2));
    });

    test('should not be equal if their properties do not match', () {
      // Arrange
      const dailyTime1 = 1625695200;
      const dailyMinTemp1 = 25.0;
      const dailyMaxTemp1 = 30.0;
      const dailyIcon1 = '01d';

      const dailyTime2 = 1625695200;
      const dailyMinTemp2 = 20.0; // Different value
      const dailyMaxTemp2 = 30.0;
      const dailyIcon2 = '01d';

      final forecastEntity1 = ForecastEntity(
        dailyTime: dailyTime1,
        dailyMinTemp: dailyMinTemp1,
        dailyMaxTemp: dailyMaxTemp1,
        dailyIcon: dailyIcon1,
      );

      final forecastEntity2 = ForecastEntity(
        dailyTime: dailyTime2,
        dailyMinTemp: dailyMinTemp2,
        dailyMaxTemp: dailyMaxTemp2,
        dailyIcon: dailyIcon2,
      );

      // Act & Assert
      expect(forecastEntity1, isNot(equals(forecastEntity2)));
    });
  });
}
