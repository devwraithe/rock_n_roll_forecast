import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/daily_forecast_entity.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/custom_icon.dart';
import '../../core/utilities/helpers/widget_helper.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  final List<ForecastEntity> forecast;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    // Group weather forecast data by day
    final Map<String, List<ForecastEntity>> groupedForecast = {};

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
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetHelper.forecastTitle(),
          const SizedBox(height: 14),
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

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: dayOfWeek ==
                                  DateFormat('EEEE').format(DateTime.now())
                              ? AppColors.darkGray
                              : AppColors.lightGray,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Text(
                          // Check if it's today, display "Today", otherwise display the day of the week
                          dayOfWeek == DateFormat('EEEE').format(DateTime.now())
                              ? 'Today'
                              : dayOfWeek,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: dayOfWeek ==
                                      DateFormat('EEEE').format(DateTime.now())
                                  ? AppColors.white
                                  : AppColors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      icon,
                      filterQuality: FilterQuality.high,
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Text(
                            '$minTemp${Constants.degree}',
                            style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  colors: [
                                    _getColorForTemp(minTemp),
                                    _getColorForTemp(maxTemp),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              height: 8,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '$maxTemp${Constants.degree}',
                            style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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

  Color _getColorForTemp(int temp) {
    if (temp < 10) {
      return Colors.blue;
    } else if (temp < 20) {
      return Colors.green;
    } else if (temp < 30) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
