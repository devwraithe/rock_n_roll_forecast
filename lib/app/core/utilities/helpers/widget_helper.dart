import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';

import '../../theme/app_colors.dart';

class WidgetHelper {
  static Text forecastTitle() {
    return Text(
      "5-DAYS FORECAST",
      style: AppTextTheme.textTheme.bodyMedium?.copyWith(
        color: AppColors.black,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
