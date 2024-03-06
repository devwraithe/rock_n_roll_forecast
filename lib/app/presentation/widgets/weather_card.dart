import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    super.key,
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "10:30 AM",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                "Overcast",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "70${Constants.degree}",
                style: textTheme.headlineLarge?.copyWith(
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Text(
                "H:76${Constants.degree} L:51${Constants.degree}",
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
