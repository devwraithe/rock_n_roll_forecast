import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';

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
}
