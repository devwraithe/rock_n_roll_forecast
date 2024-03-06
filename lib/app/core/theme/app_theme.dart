import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/input_theme.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';

import '../utilities/constants.dart';
import 'app_color_scheme.dart';

class AppTheme {
  static final theme = ThemeData(
    fontFamily: Constants.fontFamily,
    textTheme: AppTextTheme.textTheme,
    colorScheme: AppColorScheme.light,
    inputDecorationTheme: AppInputDecorationTheme.inputDecoration,
    scaffoldBackgroundColor: AppColorScheme.light.background,
    useMaterial3: true,
  );
}
