import '../../../env/env.dart';

class ApiUrls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = '&appid=${Env.openWeatherApiKey}';
  static const String units = '&units=metric';

  static String weather(String lat, String lon) {
    final url = "$baseUrl/weather?lat=$lat&lon=$lon$units$apiKey";
    return url;
  }

  static String forecast(String lat, String lon) {
    final url = "$baseUrl/forecast?lat=$lat&lon=$lon$units$apiKey";
    return url;
  }
}
