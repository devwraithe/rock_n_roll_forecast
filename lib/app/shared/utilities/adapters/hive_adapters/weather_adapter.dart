import 'package:hive/hive.dart';

import '../../../../modules/weather/domain/entities/weather_entity.dart';

class WeatherAdapter extends TypeAdapter<WeatherEntity> {
  @override
  final int typeId = 0; // Unique identifier for the adapter

  @override
  WeatherEntity read(BinaryReader reader) {
    final lat = reader.readDouble();
    final lon = reader.readDouble();
    final main = reader.readString();
    final description = reader.readString();
    final iconCode = reader.readString();
    final temperature = reader.readInt();
    final humidity = reader.readInt();
    final wind = reader.readDouble();
    final feelsLike = reader.readDouble();

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
    writer.writeDouble(obj.lat);
    writer.writeDouble(obj.lon);
    writer.writeString(obj.main);
    writer.writeString(obj.description);
    writer.writeString(obj.iconCode);
    writer.writeInt(obj.temperature);
    writer.writeInt(obj.humidity);
    writer.writeDouble(obj.wind);
    writer.writeDouble(obj.feelsLike);
  }
}
