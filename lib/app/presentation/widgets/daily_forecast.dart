import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/misc_helper.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/text_sizing_helper.dart';
import '../../core/utilities/helpers/widget_helper.dart';
import '../../domain/entities/daily_forecast_entity.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  final List<ForecastEntity> forecast;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    // Group weather forecast data by day, starting from tomorrow
    final Map<String, List<ForecastEntity>> groupedForecast = {};

    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));

    for (final day in forecast) {
      final forecastDate = DateTime.fromMillisecondsSinceEpoch(
        day.dailyTime * 1000,
      );
      final formattedDay = DateFormat('EEEE').format(forecastDate);

      // Skip today's forecast
      if (forecastDate.day == now.day) continue;

      // Use "tomorrow" instead of the actual day for the next day's forecast
      if (forecastDate.day == tomorrow.day) {
        groupedForecast['Tomorrow'] = [day];
        continue;
      }

      if (!groupedForecast.containsKey(formattedDay)) {
        groupedForecast[formattedDay] = [];
      }
      groupedForecast[formattedDay]!.add(day);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile ? 18 : 36,
      ),
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

              final icon = MiscHelper.getCustomIcon(
                forecastList.first.dailyIcon,
              );

              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: Responsive.isMobile ? 10 : 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: dayOfWeek == "Tomorrow"
                              ? AppColors.darkGray
                              : AppColors.lightGray,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: Responsive.isMobile ? 12 : 22,
                        ),
                        child: Text(
                          dayOfWeek,
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: dayOfWeek == "Tomorrow"
                                ? AppColors.white
                                : AppColors.darkGray,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: Responsive.isMobile ? 16 : 32),
                    Image.asset(
                      icon,
                      filterQuality: FilterQuality.high,
                      width: Responsive.isMobile ? 36 : 62,
                      height: Responsive.isMobile ? 36 : 62,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: Responsive.isMobile ? 16 : 32),
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
                          SizedBox(width: Responsive.isMobile ? 10 : 20),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                gradient: LinearGradient(
                                  colors: [
                                    MiscHelper.getColorForTemp(minTemp),
                                    MiscHelper.getColorForTemp(maxTemp),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              height: Responsive.isMobile ? 8 : 12,
                            ),
                          ),
                          SizedBox(width: Responsive.isMobile ? 10 : 20),
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
}
