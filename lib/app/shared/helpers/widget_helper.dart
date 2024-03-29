import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/theme/text_theme.dart';

import '../theme/app_colors.dart';

class WidgetHelper {
  static Widget error(String text) {
    return Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextTheme.textTheme.bodyLarge?.copyWith(
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
