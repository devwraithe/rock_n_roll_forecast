import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/navigation_helper.dart';

import '../../../domain/entities/location_entity.dart';
import 'misc_helper.dart';

class LocationHelper {
  static Future<Map<String, double>> cityCoordinates(String city) async {
    try {
      List<Location> locations = await locationFromAddress(city);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return {
          'latitude': location.latitude,
          'longitude': location.longitude,
        };
      }
    } catch (e) {
      debugPrint('${Constants.coordRetrieveError} - $e');
      throw Exception("${Constants.coordRetrieveError} for $city");
    }
    throw Exception('${Constants.failedCoordinates} for $city');
  }

  static Future<void> getCoordinates(
    BuildContext context,
    LocationEntity location,
    Map<String, ValueNotifier<bool>> loadingStates,
  ) async {
    void navigate(Map<String, double> coordinates) {
      return NavigationHelper.goToConcertInfo(
        context,
        coordinates,
        location,
      );
    }

    final hasInternet = await MiscHelper.hasInternetConnection();
    loadingStates[location.city]?.value = true;

    if (hasInternet) {
      final coordinates = await LocationHelper.cityCoordinates(
        "${location.city}, ${location.country}",
      );
      navigate(coordinates);
    } else {
      navigate({});
    }

    loadingStates[location.city]?.value = false;
  }
}
