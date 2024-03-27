import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/services/location_service.dart';

import '../../../domain/entities/location_entity.dart';
import '../../../presentation/routes/routes.dart';
import 'misc_helper.dart';

class NavigationHelper {
  static Future<void> goToConcertInfo(
    BuildContext context,
    LocationService locationService,
    LocationEntity location,
    Map<String, ValueNotifier<bool>> loadingStates,
  ) async {
    // Child function to handle the navigation
    void navigate(Object? arguments) {
      Navigator.pushNamed(
        context,
        Routes.concertInfo,
        arguments: arguments,
      );
    }

    final hasInternet = await MiscHelper.hasInternetConnection();
    loadingStates[location.city]?.value = true;

    try {
      if (hasInternet) {
        final coordinates = await locationService.getCoordinates(
          "${location.city}, ${location.country}",
        );
        navigate({
          'coordinates': coordinates,
          'location': "${location.city}, ${location.country}",
        });
      } else {
        navigate({});
      }
    } catch (e) {
      debugPrint('Error navigating to concert info: $e');
      // Handle error appropriately (e.g., show error message)
    }

    loadingStates[location.city]?.value = false;
  }
}
