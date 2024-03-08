import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

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
      debugPrint('Error getting coordinates for $city: $e');
    }
    throw Exception('Failed to get coordinates for $city');
  }
}
