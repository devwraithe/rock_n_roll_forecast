import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:timezone/timezone.dart' as tz;

class LocationHelper {
  static Future<Map<String, double>> cityCoordinates(String city) async {
    final connectivity = Connectivity();
    final connectivityResult = await connectivity.checkConnectivity();
    final hasInternet = connectivityResult != ConnectivityResult.none;

    if (hasInternet)
      debugPrint("Internet is available!");
    else
      debugPrint("Internet is not available");

    try {
      List<Location> locations = await locationFromAddress(city);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        return {'latitude': location.latitude, 'longitude': location.longitude};
      }
    } catch (e) {
      debugPrint('Error getting coordinates for $city: $e');
    }
    throw Exception('Failed to get coordinates for $city');
  }

  static Future<DateTime> getCurrentTimeForCity(String cityName) async {
    try {
      // Retrieve timezone information for the city
      final location = tz.getLocation(cityName);

      // Get the current UTC time
      final utcTime = tz.TZDateTime.now(tz.UTC);

      // Convert UTC time to local time of the city
      final localTime = utcTime.toLocal();

      return localTime;
    } catch (e) {
      print('Error: $e');
      // Return null or throw an error as appropriate
      return DateTime.now(); // Return current time as fallback
    }
  }
}
