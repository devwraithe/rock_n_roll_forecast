import '../../../env/env.dart';

class ApiUrls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String geoUrl = 'http://api.openweathermap.org/geo/1.0/';
  static const String apiKey = '&appid=${Env.openWeatherApiKey}';
  static const String units = '&units=metric';

  // static String currentWeather(String city) =>
  //     '$baseUrl/weather?q=$city$units$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';

  static String currentWeather(String lat, String lon) {
    final url = "$baseUrl/weather?lat=$lat&lon=$lon&$apiKey";
    return url;
  }

  static String fiveDaysForecast(String lat, String lon) {
    final url = "$baseUrl/forecast?lat=$lat&lon=$lon&$apiKey";
    return url;
  }
}
