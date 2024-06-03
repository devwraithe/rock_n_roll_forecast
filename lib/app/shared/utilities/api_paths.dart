import 'package:rock_n_roll_forecast/app/shared/utilities/env_config.dart';

class ApiUrls {
  static String baseUrl = '${EnvConfig.baseUrl}/data/2.5';
  static String appId = '&appid=${EnvConfig.appId}';
  static const String units = '&units=metric';

  static String weather(String lat, String lon) {
    final url = "$baseUrl/weather?lat=$lat&lon=$lon$units$appId";
    return url;
  }

  static String forecast(String lat, String lon) {
    final url = "$baseUrl/forecast?lat=$lat&lon=$lon$units$appId";
    return url;
  }
}
