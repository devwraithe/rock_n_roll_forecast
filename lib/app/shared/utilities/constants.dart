import '../../modules/weather/domain/entities/location_entity.dart';

class Constants {
  // Strings
  static String fontFamily = 'Satoshi';
  static String weatherServerError = "Error retrieving weather";
  static String forecastsServerError = "Error retrieving forecasts";
  static String coordRetrieveError = "Error getting coordinates";
  static String failedCoordinates = "Failed to get coordinates";
  static String clickForMore = "View";
  static String offlineError = "This data is unavailable offline";
  static String invalidError = "Invalid data type in cache";
  static String unknownError = "Something went wrong";
  static String localUnknownError = "Something went wrong in local storage";
  static String lostConnection = "Please check your internet connection.";
  static String connectionTimeout = "Request timed out";
  static String degree = "\u{00B0}";
  static String weathersBox = "weathers";
  static String forecastsBox = "forecasts";

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

  // Maps
  static final headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };
}
