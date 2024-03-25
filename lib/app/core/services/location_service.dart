import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

import '../utilities/constants.dart';

abstract class LocationService {
  Future<Map<String, double>> getCoordinates(String city);
}

class LocationServiceImpl implements LocationService {
  const LocationServiceImpl();

  @override
  Future<Map<String, double>> getCoordinates(String city) async {
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
