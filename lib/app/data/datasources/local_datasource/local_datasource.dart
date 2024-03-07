import '../../../domain/entities/daily_forecast_entity.dart';
import '../../../domain/entities/weather_entity.dart';

abstract class LocalDatasource {
  Future<void> cacheWeather(WeatherEntity weather, String city);
  Future<WeatherEntity?> offlineWeather(String city);
  Future<void> cacheForecast(List<ForecastEntity> forecasts, String city);
  Future<List<ForecastEntity>> offlineForecasts(String city);
}
