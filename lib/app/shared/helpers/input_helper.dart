import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/responsive.dart';

class InputHelper {
  static OutlineInputBorder inputStyle(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 1.2,
      ),
      borderRadius: BorderRadius.circular(
        Responsive.isMobile ? 10 : 12,
      ),
    );
  }
}
