class Constants {
  // string constants
  static String fontFamily = 'Satoshi';
  static String baseUrl = "https://api.nasa.gov";
  static String apiPath = "";
  // "$baseUrl/planetary/apod?api_key=${Env.apiKey}&start_date=2023-06-20";
  static String serverError = "Error retrieving weathers";
  static String offlineError = "This data is unavailable offline";
  static String socketError = "No Internet Connection";
  static String unknownError = "Something went wrong";
  static String lostConnection = "Please check your internet connection.";
  static String timeout = "Request timed out. Please try again later.";
  static String degree = "\u{00B0}";

  // Double constants
  static double imageHeight = 240;
  static double inputRadius = 8;

  // Lists
  static List concertCities = [
    "Silverstone, UK",
    "São Paulo, Brazil",
    "Melbourne, Australia",
    "Monte Carlo, Monaco"
  ];
}
