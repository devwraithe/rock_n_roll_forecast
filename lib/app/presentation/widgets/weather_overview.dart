import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/misc_helper.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/responsive_helper.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_helper.dart';

import '../../core/theme/text_theme.dart';
import '../../core/utilities/constants.dart';

class WeatherOverview extends StatelessWidget {
  const WeatherOverview({
    super.key,
    required this.location,
    required this.condition,
    required this.temperature,
    required this.humidity,
    required this.icon,
    required this.wind,
    required this.feelsLike,
  });

  final String condition, temperature, location, humidity, icon;
  final num wind, feelsLike;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "$temperature${Constants.degree}",
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: Responsive.isMobile ? 28 : 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TextHelper.capitalizeLetter(condition),
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(
              MiscHelper.getCustomIcon(icon),
              width: 30,
              height: 30,
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.darkGray10,
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _weatherMetric(
                "wind",
                "Wind",
                "${wind.round()}m/s",
              ),
              _weatherMetric(
                "humidity",
                "Humidity",
                "$humidity%",
              ),
              _weatherMetric(
                "temp",
                "Feels",
                "${feelsLike.round()}${Constants.degree}",
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Column _weatherMetric(String icon, String key, String value) {
    return Column(
      children: [
        Image.asset(
          "assets/icons/$icon.png",
          width: 36,
          height: 36,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: AppTextTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          key,
          style: AppTextTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }
}
