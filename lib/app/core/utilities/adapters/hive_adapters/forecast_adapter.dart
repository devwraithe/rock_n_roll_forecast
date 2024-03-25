import 'package:hive/hive.dart';

import '../../../../domain/entities/forecast_entity.dart';

class ForecastAdapter extends TypeAdapter<ForecastEntity> {
  @override
  final int typeId = 1; // Unique identifier for the adapter

  @override
  ForecastEntity read(BinaryReader reader) {
    final dailyTime = reader.read();
    final dailyMinTemp = reader.read();
    final dailyMaxTemp = reader.read();
    final dailyIcon = reader.read();

    return ForecastEntity(
      dailyTime: dailyTime,
      dailyMinTemp: dailyMinTemp,
      dailyMaxTemp: dailyMaxTemp,
      dailyIcon: dailyIcon,
    );
  }

  @override
  void write(BinaryWriter writer, ForecastEntity obj) {
    writer.write(obj.dailyTime);
    writer.write(obj.dailyMinTemp);
    writer.write(obj.dailyMaxTemp);
    writer.write(obj.dailyIcon);
  }
}
