import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/shared/theme/app_color_scheme.dart';

void main() {
  test('AppColorScheme should have correct color scheme', () {
    expect(AppColorScheme.light.primary, AppColors.black);
    expect(AppColorScheme.light.secondary, AppColors.white);
    expect(AppColorScheme.light.background, Colors.white);
  });
}
