import 'package:hive/hive.dart';

import '../../../../domain/entities/weather_entity.dart';

class WeatherAdapter extends TypeAdapter<WeatherEntity> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  WeatherEntity read(BinaryReader reader) {
    final lat = reader.read();
    final lon = reader.read();
    final main = reader.read();
    final description = reader.read();
    final iconCode = reader.read();
    final temperature = reader.read();
    final humidity = reader.read();
    final wind = reader.read();
    final feelsLike = reader.read();

    return WeatherEntity(
      lat: lat,
      lon: lon,
      main: main,
      description: description,
      iconCode: iconCode,
      temperature: temperature,
      humidity: humidity,
      wind: wind,
      feelsLike: feelsLike,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherEntity obj) {
    writer.write(obj.lat);
    writer.write(obj.lon);
    writer.write(obj.main);
    writer.write(obj.description);
    writer.write(obj.iconCode);
    writer.write(obj.temperature);
    writer.write(obj.humidity);
    writer.write(obj.wind);
    writer.write(obj.feelsLike);
  }
}
