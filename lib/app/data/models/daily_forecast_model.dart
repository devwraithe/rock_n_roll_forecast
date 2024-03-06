import 'package:equatable/equatable.dart';

import '../../domain/entities/daily_forecast_entity.dart';

class DailyForecastModel extends Equatable {
  final int dailyTime;
  final num dailyMinTemp, dailyMaxTemp;
  final String dailyIcon;

  const DailyForecastModel({
    required this.dailyTime,
    required this.dailyMinTemp,
    required this.dailyMaxTemp,
    required this.dailyIcon,
  });

  factory DailyForecastModel.fromJson(Map<String, dynamic> json) =>
      DailyForecastModel(
        dailyTime: json["dt"],
        dailyMinTemp: json['main']['temp_min'],
        dailyMaxTemp: json['main']['temp_max'],
        dailyIcon: json["weather"][0]["icon"],
      );

  DailyForecastEntity toEntity() => DailyForecastEntity(
        dailyTime: dailyTime,
        dailyMinTemp: dailyMinTemp,
        dailyMaxTemp: dailyMaxTemp,
        dailyIcon: dailyIcon,
      );

  @override
  List<Object?> get props => [
        dailyTime,
        dailyMinTemp,
        dailyMaxTemp,
        dailyIcon,
      ];
}
