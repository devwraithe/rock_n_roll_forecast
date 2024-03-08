import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/input_helper.dart';

import 'app_colors.dart';

class AppInputDecorationTheme {
  static const gray = AppColors.grey;

  static final inputDecoration = InputDecorationTheme(
    hintStyle: AppTextTheme.textTheme.bodyMedium?.copyWith(color: gray),
    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
    border: InputHelper.inputStyle(AppColors.grey),
    enabledBorder: InputHelper.inputStyle(AppColors.grey),
    focusedBorder: InputHelper.inputStyle(AppColors.black),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    isDense: true,
  );
}
