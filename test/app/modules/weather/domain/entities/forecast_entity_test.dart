import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/forecast_entity.dart';

void main() {
  test('Should initialize with the correct values', () {
    const dailyTime = 1625695200;
    const dailyMinTemp = 25.0;
    const dailyMaxTemp = 30.0;
    const dailyIcon = '01d';

    const forecastEntity = ForecastEntity(
      dailyTime: dailyTime,
      dailyMinTemp: dailyMinTemp,
      dailyMaxTemp: dailyMaxTemp,
      dailyIcon: dailyIcon,
    );

    expect(forecastEntity.dailyTime, dailyTime);
    expect(forecastEntity.dailyMinTemp, dailyMinTemp);
    expect(forecastEntity.dailyMaxTemp, dailyMaxTemp);
    expect(forecastEntity.dailyIcon, dailyIcon);
  });

  test('Should be equal if their properties match', () {
    const dailyTime = 1625695200;
    const dailyMinTemp = 25.0;
    const dailyMaxTemp = 30.0;
    const dailyIcon = '01d';

    const forecastEntity1 = ForecastEntity(
      dailyTime: dailyTime,
      dailyMinTemp: dailyMinTemp,
      dailyMaxTemp: dailyMaxTemp,
      dailyIcon: dailyIcon,
    );

    const forecastEntity2 = ForecastEntity(
      dailyTime: dailyTime,
      dailyMinTemp: dailyMinTemp,
      dailyMaxTemp: dailyMaxTemp,
      dailyIcon: dailyIcon,
    );

    expect(forecastEntity1, equals(forecastEntity2));
  });

  test('Should not be equal if their properties do not match', () {
    const dailyTime1 = 1625695200;
    const dailyMinTemp1 = 25.0;
    const dailyMaxTemp1 = 30.0;
    const dailyIcon1 = '01n';

    const dailyTime2 = 1625695200;
    const dailyMinTemp2 = 20.0;
    const dailyMaxTemp2 = 30.0;
    const dailyIcon2 = '01d';

    const forecastEntity1 = ForecastEntity(
      dailyTime: dailyTime1,
      dailyMinTemp: dailyMinTemp1,
      dailyMaxTemp: dailyMaxTemp1,
      dailyIcon: dailyIcon1,
    );

    const forecastEntity2 = ForecastEntity(
      dailyTime: dailyTime2,
      dailyMinTemp: dailyMinTemp2,
      dailyMaxTemp: dailyMaxTemp2,
      dailyIcon: dailyIcon2,
    );

    expect(forecastEntity1, isNot(equals(forecastEntity2)));
  });
}
