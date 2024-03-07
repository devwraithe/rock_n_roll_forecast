import '../../domain/entities/city_entity.dart';

class Constants {
  // string constants
  static String fontFamily = 'Satoshi';
  static String serverError = "Error retrieving weathers";
  static String offlineError = "This data is unavailable offline";
  static String socketError = "No Internet Connection";
  static String unknownError = "Something went wrong";
  static String lostConnection = "Please check your internet connection.";
  static String timeout = "Request timed out. Please try again later.";
  static String degree = "\u{00B0}";
  static String unsplashUrl = "https://images.unsplash.com";
  static String compressor =
      "?q=80&w=2275&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";

  // Double constants
  static double imageHeight = 240;
  static double inputRadius = 8;

  static List concertCities = [
    CityEntity(
      name: "Silverstone, UK",
      image: "$unsplashUrl/photo-1578002171601-902a5a7645a9$compressor",
    ),
    CityEntity(
      name: "São Paulo, Brazil",
      image: "$unsplashUrl/photo-1679671653086-bd28ea45f757$compressor",
    ),
    CityEntity(
      name: "Melbourne, Australia",
      image: "$unsplashUrl/photo-1583032586422-4a31c5386d9f$compressor",
    ),
    CityEntity(
      name: "Monte Carlo, Monaco",
      image: "$unsplashUrl/photo-1559503159-89d94cb6eb57$compressor",
    ),
  ];
}
