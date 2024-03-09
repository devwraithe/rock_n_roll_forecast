import '../../../domain/entities/daily_forecast_entity.dart';
import '../../../domain/entities/weather_entity.dart';

abstract class WeatherLocalDatasource {
  Future<void> cacheWeather(WeatherEntity weather, String city);
  Future<WeatherEntity?> offlineWeather(String city);
}

abstract class ForecastLocalDatasource {
  Future<void> cacheForecast(List<ForecastEntity> forecasts, String city);
  Future<List<ForecastEntity>> offlineForecasts(String city);
}
