import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/shared/theme/app_colors.dart';

void main() {
  // test case: should have correct color values
  test('should have correct color values', () {
    // assert that the color values are as expected
    expect(AppColors.black, const Color(0xFF0D0D0D));
    expect(AppColors.darkGray, const Color(0xFF181818));
    expect(AppColors.white, const Color(0xFFFFFFFF));
    expect(AppColors.grey, const Color(0xFFB7B7B7));
    expect(AppColors.lightGray, const Color(0xFFD7D7D7));
  });
}
