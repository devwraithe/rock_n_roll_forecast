import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/theme/text_theme.dart';

import '../utilities/constants.dart';
import 'app_color_scheme.dart';
import 'input_theme.dart';

class AppTheme {
  static final theme = ThemeData(
    fontFamily: Constants.fontFamily,
    textTheme: AppTextTheme.textTheme,
    colorScheme: AppColorScheme.dark,
    inputDecorationTheme: AppInputDecorationTheme.inputDecoration,
    scaffoldBackgroundColor: AppColorScheme.dark.background,
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
