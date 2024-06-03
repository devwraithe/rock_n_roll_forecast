import 'package:flutter/material.dart';

import '../../modules/weather/domain/entities/location_entity.dart';
import '../routes/routes.dart';

class NavigationHelper {
  static Future<void> goToConcertInfo(
    BuildContext context,
    LocationEntity location,
  ) async {
    void navigate(Object? arguments) {
      Navigator.pushNamed(
        context,
        Routes.concertInfo,
        arguments: arguments,
      );
    }

    try {
      navigate({
        'location': "${location.city}, ${location.country}",
      });
    } catch (e) {
      debugPrint('Error navigating to concert info: $e');
      throw Exception("Error navigating to concert info");
    }
  }
}
