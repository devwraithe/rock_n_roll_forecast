import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/misc_helper.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/responsive_helper.dart';
import '../../domain/entities/daily_forecast_entity.dart';

class WeatherForecast extends StatelessWidget {
  const WeatherForecast({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  final List<ForecastEntity> forecast;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;
    final isMobile = Responsive.isMobile;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          margin: EdgeInsets.only(
            bottom: isMobile ? 32 : 56,
          ),
          child: Row(
            children: [
              Expanded(
                flex: isMobile ? 3 : 2,
                child: Text(
                  dayOfWeek,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Text(
                      '$minTemp${Constants.degree}',
                      style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.grey,
                      ),
                    ),
                    SizedBox(width: Responsive.isMobile ? 16 : 20),
                    _indicator(minTemp, maxTemp),
                    SizedBox(width: Responsive.isMobile ? 16 : 20),
                    Text(
                      '$maxTemp${Constants.degree}',
                      style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: Responsive.isMobile ? 28 : 48),
              Image.asset(
                icon,
                filterQuality: FilterQuality.high,
                width: Responsive.isMobile ? 34 : 62,
                height: Responsive.isMobile ? 34 : 62,
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _indicator(int minTemp, int maxTemp) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(top: 1),
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
        height: Responsive.isMobile ? 7 : 12,
      ),
    );
  }
}
