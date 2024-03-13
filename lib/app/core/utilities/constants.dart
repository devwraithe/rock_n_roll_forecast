import '../../domain/entities/location_entity.dart';

class Constants {
  // Strings
  static String fontFamily = 'Satoshi';
  static String serverError = "Error retrieving weathers";
  static String gatheringCoordinates = "Gathering coordinates";
  static String clickForMore = "View";
  static String offlineError = "This data is unavailable offline";
  static String invalidError = "Invalid data type in Hive box";
  static String socketError = "No Internet Connection";
  static String unknownError = "Something went wrong";
  static String lostConnection = "Please check your internet connection.";
  static String timeout = "Request timed out. Please try again later.";
  static String degree = "\u{00B0}";

  // Doubles
  static double inputRadius = 8;

  // Lists
  static const List concertCities = [
    LocationEntity(
      city: "Silverstone",
      country: "UK",
    ),
    LocationEntity(
      city: "São Paulo",
      country: "Brazil",
    ),
    LocationEntity(
      city: "Melbourne",
      country: "Australia",
    ),
    LocationEntity(
      city: "Monte Carlo",
      country: "Monaco",
    ),
  ];
}
