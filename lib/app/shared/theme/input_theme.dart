import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/helpers/input_helper.dart';

import '../utilities/helpers/responsive_helper.dart';
import 'app_colors.dart';

class AppInputDecorationTheme {
  static const gray = AppColors.grey;

  static final inputDecoration = InputDecorationTheme(
    hintStyle: AppTextTheme.textTheme.bodyMedium?.copyWith(color: gray),
    contentPadding: Responsive.isMobile
        ? const EdgeInsets.symmetric(horizontal: 18, vertical: 14)
        : const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
    border: InputHelper.inputStyle(AppColors.grey),
    enabledBorder: InputHelper.inputStyle(AppColors.grey),
    focusedBorder: InputHelper.inputStyle(AppColors.grey),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    isDense: true,
  );
}
