import 'package:hive/hive.dart';

import '../../../domain/entities/current_weather_entity.dart';

class CurrentWeatherEntityAdapter extends TypeAdapter<CurrentWeatherEntity> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  CurrentWeatherEntity read(BinaryReader reader) {
    final lat = reader.read();
    final lon = reader.read();
    final cityName = reader.read();
    final sunrise = reader.read();
    final sunset = reader.read();
    final feelsLike = reader.read();
    final main = reader.read();
    final description = reader.read();
    final iconCode = reader.read();
    final countryAbbr = reader.read();
    final temperature = reader.read();
    final pressure = reader.read();
    final humidity = reader.read();
    final windSpeed = reader.read();

    return CurrentWeatherEntity(
      lat: lat,
      lon: lon,
      cityName: cityName,
      sunrise: sunrise,
      sunset: sunset,
      feelsLike: feelsLike,
      main: main,
      description: description,
      iconCode: iconCode,
      countryAbbr: countryAbbr,
      temperature: temperature,
      pressure: pressure,
      humidity: humidity,
      windSpeed: windSpeed,
    );
  }

  @override
  void write(BinaryWriter writer, CurrentWeatherEntity obj) {
    writer.write(obj.lat);
    writer.write(obj.lon);
    writer.write(obj.cityName);
    writer.write(obj.sunrise);
    writer.write(obj.sunset);
    writer.write(obj.feelsLike);
    writer.write(obj.main);
    writer.write(obj.description);
    writer.write(obj.iconCode);
    writer.write(obj.countryAbbr);
    writer.write(obj.temperature);
    writer.write(obj.pressure);
    writer.write(obj.humidity);
    writer.write(obj.windSpeed); // Write windSpeed as a
  }
}
