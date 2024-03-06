import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/input_helper.dart';

import '../utilities/helpers/text_sizing_helper.dart';
import 'app_colors.dart';

class AppInputDecorationTheme {
  static const gray = AppColors.grey;

  static final inputDecoration = InputDecorationTheme(
    hintStyle: Responsive.isMobile
        ? AppTextTheme.textTheme.bodyMedium?.copyWith(color: gray)
        : AppTextTheme.textTheme.bodyLarge?.copyWith(color: gray),
    contentPadding: Responsive.isMobile
        ? const EdgeInsets.fromLTRB(20, 24, 20, 14)
        : const EdgeInsets.fromLTRB(30, 36, 30, 26),
    border: InputHelper.inputStyle(AppColors.grey),
    enabledBorder: InputHelper.inputStyle(AppColors.grey),
    focusedBorder: InputHelper.inputStyle(AppColors.black),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    isDense: true,
  );
}
