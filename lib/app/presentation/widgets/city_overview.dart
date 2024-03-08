import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_helper.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_sizing_helper.dart';

import '../../core/theme/text_theme.dart';
import '../../core/utilities/constants.dart';

class CityOverview extends StatelessWidget {
  const CityOverview({
    super.key,
    required this.location,
    required this.condition,
    required this.temperature,
  });

  final String condition, temperature, location;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: Responsive.isMobile ? 24 : 30,
            ),
          ),
        ),
        const SizedBox(height: 60),
        Text(
          location,
          style: textTheme.headlineMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
        SizedBox(height: Responsive.isMobile ? 12 : 8),
        Text(
          "$temperature${Constants.degree}",
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
        SizedBox(height: Responsive.isMobile ? 12 : 18),
        Text(
          TextHelper.capitalizeLetter(condition),
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
