import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/custom_icon.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  final List<DailyForecastEntity> forecast;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    // Group forecast data by day
    final Map<String, List<DailyForecastEntity>> groupedForecast = {};
    for (final day in forecast) {
      final formattedDay = DateFormat('EEEE').format(
        DateTime.fromMillisecondsSinceEpoch(day.dailyTime * 1000),
      );
      if (!groupedForecast.containsKey(formattedDay)) {
        groupedForecast[formattedDay] = [];
      }
      groupedForecast[formattedDay]!.add(day);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.black.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "5-Day Forecast",
            style: textTheme.labelMedium?.copyWith(
              color: Colors.grey,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: groupedForecast.entries.map((entry) {
              final dayOfWeek = entry.key;
              final forecastList = entry.value;

              final minTemp = forecastList
                  .map((forecast) => forecast.dailyMinTemp.round())
                  .reduce((min, temp) => temp < min ? temp : min);
              final maxTemp = forecastList
                  .map((forecast) => forecast.dailyMaxTemp.round())
                  .reduce((max, temp) => temp > max ? temp : max);
              final icon = getCustomIcon(forecastList.first.dailyIcon);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        dayOfWeek,
                        style: textTheme.bodyText1?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Image.asset(
                      icon,
                      filterQuality: FilterQuality.high,
                      width: 36,
                      height: 36,
                    ),
                    SizedBox(width: 12),
                    Text(
                      '$minTemp° - $maxTemp°',
                      style: textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
