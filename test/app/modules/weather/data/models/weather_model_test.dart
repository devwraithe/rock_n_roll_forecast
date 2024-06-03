import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/data/models/weather_model.dart';

void main() {
  test('fromJson should parse JSON correctly', () {
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
        "temp": 283,
        "feels_like": 283.0,
        "humidity": 70,
      },
      "wind": {
        "speed": 2.0,
      },
    };

    final weatherModel = WeatherModel.fromJson(json);

    expect(weatherModel.lat, equals(51.51));
    expect(weatherModel.lon, equals(-0.13));
    expect(weatherModel.main, equals("Clear"));
    expect(weatherModel.description, equals("clear sky"));
    expect(weatherModel.iconCode, equals("01d"));
    expect(weatherModel.temperature, equals(283));
    expect(weatherModel.feelsLike, equals(283));
    expect(weatherModel.wind, equals(2));
    expect(weatherModel.humidity, equals(70));
  });

  test('Should convert WeatherModel to WeatherEntity', () {
    const weatherModel = WeatherModel(
      lon: 10.0,
      lat: 20.0,
      wind: 5.0,
      feelsLike: 25,
      main: 'Clear',
      description: 'Clear sky',
      iconCode: '01d',
      humidity: 70,
      temperature: 25,
    );

    final result = weatherModel.toEntity();

    expect(result.lat, equals(20.0));
    expect(result.lon, equals(10.0));
    expect(result.wind, equals(5.0));
    expect(result.feelsLike, equals(25));
    expect(result.main, equals('Clear'));
    expect(result.description, equals('Clear sky'));
    expect(result.iconCode, equals('01d'));
    expect(result.temperature, equals(25));
    expect(result.humidity, equals(70));
  });

  test('Should props contains all properties', () {
    const weatherModel = WeatherModel(
      lon: 10.0,
      lat: 20.0,
      wind: 5.0,
      feelsLike: 25,
      main: 'Clear',
      description: 'Clear sky',
      iconCode: '01d',
      humidity: 70,
      temperature: 25,
    );

    final props = weatherModel.props;

    expect(props.contains(10.0), isTrue);
    expect(props.contains(20.0), isTrue);
    expect(props.contains(5.0), isTrue);
    expect(props.contains(25.0), isTrue);
    expect(props.contains('Clear'), isTrue);
    expect(props.contains('Clear sky'), isTrue);
    expect(props.contains('01d'), isTrue);
    expect(props.contains(25), isTrue);
    expect(props.contains(70), isTrue);
  });
}
