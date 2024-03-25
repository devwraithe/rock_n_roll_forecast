import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/data/models/forecast_model.dart';

void main() {
  test('fromJson should parse JSON correctly', () {
    final json = {
      "dt": 1615377600,
      "main": {
        "temp_min": 20,
        "temp_max": 30,
      },
      "weather": [
        {
          "icon": "01d",
        }
      ]
    };

    final forecastModel = ForecastModel.fromJson(json);

    expect(forecastModel.dailyTime, equals(1615377600));
    expect(forecastModel.dailyMinTemp, equals(20));
    expect(forecastModel.dailyMaxTemp, equals(30));
    expect(forecastModel.dailyIcon, equals("01d"));
  });

  test('Should convert ForecastModel to ForecastEntity', () {
    const forecastModel = ForecastModel(
      dailyTime: 1615377600,
      dailyMinTemp: 20,
      dailyMaxTemp: 30,
      dailyIcon: "01d",
    );

    final result = forecastModel.toEntity();

    expect(result.dailyTime, equals(1615377600));
    expect(result.dailyMinTemp, equals(20));
    expect(result.dailyMaxTemp, equals(30));
    expect(result.dailyIcon, equals("01d"));
  });

  test('Should props contains all properties', () {
    const forecastModel = ForecastModel(
      dailyTime: 1615377600,
      dailyMinTemp: 20,
      dailyMaxTemp: 30,
      dailyIcon: "01d",
    );

    final props = forecastModel.props;

    expect(props.contains(1615377600), isTrue);
    expect(props.contains(20), isTrue);
    expect(props.contains(30), isTrue);
    expect(props.contains('01d'), isTrue);
  });
}
