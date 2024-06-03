import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class WeatherHelper {
  static String getCustomIcon(String weatherConditionCode) {
    switch (weatherConditionCode) {
      case '01d' || '01n':
        return 'assets/icons/clear_sky.png';
      case '02d' || '02n':
        return 'assets/icons/few_clouds.png';
      case '03d' || '03n':
        return 'assets/icons/scattered_clouds.png';
      case '04d' || '04n':
        return 'assets/icons/broken_clouds.png';
      case '09d' || '09n':
        return 'assets/icons/shower_rain.png';
      case '10d' || '10n':
        return 'assets/icons/rain.png';
      case '11d' || '11n':
        return 'assets/icons/thunderstorm.png';
      case '13d' || '13n':
        return 'assets/icons/snow.png';
      case '50d' || '50n':
        return 'assets/icons/snow.png';
      default:
        return 'assets/icons/sunny.png';
    }
  }

  static Color getColorForTemp(int temp) {
    if (temp < 10) {
      return AppColors.blue;
    } else if (temp < 20) {
      return AppColors.green;
    } else if (temp < 30) {
      return AppColors.yellow;
    } else {
      return AppColors.red;
    }
  }
}
