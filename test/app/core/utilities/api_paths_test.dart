import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/api_paths.dart';
import 'package:rock_n_roll_forecast/env/env.dart';

void main() {
  const lat = '1.0';
  const lon = '-1.0';

  group('ApiUrls', () {
    const String baseUrl = 'https://api.openweathermap.org/data/2.5';
    const String apiKey = '&appid=${Env.openWeatherApiKey}';
    const String units = '&units=metric';

    test('Weather URL construction test', () {
      const expectedWeatherUrl =
          '$baseUrl/weather?lat=$lat&lon=$lon$units$apiKey';
      final actualWeatherUrl = ApiUrls.weather(lat, lon);
      expect(actualWeatherUrl, expectedWeatherUrl);
    });

    test('Forecast URL construction test', () {
      const expectedForecastUrl =
          '$baseUrl/forecast?lat=$lat&lon=$lon$units$apiKey';
      final actualForecastUrl = ApiUrls.forecast(lat, lon);
      expect(actualForecastUrl, expectedForecastUrl);
    });
  });
}
