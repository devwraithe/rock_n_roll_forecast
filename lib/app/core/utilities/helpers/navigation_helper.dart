import 'package:flutter/material.dart';

import '../../../domain/entities/location_entity.dart';
import '../../routes/routes.dart';

class NavigationHelper {
  static void goToConcertInfo(
    BuildContext context,
    Map<String, double> coordinates,
    LocationEntity location,
  ) {
    Navigator.pushNamed(
      context,
      Routes.concertInfo,
      arguments: {
        'coordinates': coordinates,
        'location': "${location.city}, ${location.country}",
      },
    );
  }
}
