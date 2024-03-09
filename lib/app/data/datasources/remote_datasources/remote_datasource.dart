import '../../models/forecast_model.dart';
import '../../models/weather_model.dart';

abstract class WeatherRemoteDatasource {
  Future<WeatherModel> getWeather(String lat, String lon);
}

abstract class ForecastRemoteDatasource {
  Future<List<ForecastModel>> getForecast(String lat, String lon);
}
