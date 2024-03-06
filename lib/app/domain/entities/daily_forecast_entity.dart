import 'package:equatable/equatable.dart';

class DailyForecastEntity extends Equatable {
  final int dailyTime;
  final num dailyMinTemp, dailyMaxTemp;
  final String dailyIcon;

  const DailyForecastEntity({
    required this.dailyTime,
    required this.dailyMinTemp,
    required this.dailyMaxTemp,
    required this.dailyIcon,
  });

  @override
  List<Object?> get props => [
        dailyTime,
        dailyMinTemp,
        dailyMaxTemp,
        dailyIcon,
      ];
}
