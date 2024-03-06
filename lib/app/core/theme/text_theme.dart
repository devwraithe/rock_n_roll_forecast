import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_sizing_helper.dart';

@immutable
class AppTextTheme {
  static TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: Responsive.headlineLarge,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: Responsive.headlineMedium,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: TextStyle(
      fontSize: Responsive.headlineSmall,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontSize: Responsive.bodyLarge,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontSize: Responsive.bodyMedium,
      fontWeight: FontWeight.w400,
    ),
  );
}
