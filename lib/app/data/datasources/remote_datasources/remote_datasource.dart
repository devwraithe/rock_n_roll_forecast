import '../../models/daily_forecast_model.dart';
import '../../models/weather_model.dart';

abstract class RemoteDatasource {
  Future<WeatherModel> getWeather(String lat, String lon);
  Future<List<DailyForecastModel>> forecast(String lat, String lon);
}
