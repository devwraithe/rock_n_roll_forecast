import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/helpers/responsive_helper.dart';

class InputHelper {
  static inputStyle(Color color) {
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
