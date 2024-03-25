import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';

void main() {
  test(
    'All constants are defined correctly',
    () {
      expect(Constants.fontFamily, equals('Satoshi'));
      expect(Constants.weatherServerError, equals('Error retrieving weather'));
      expect(
          Constants.forecastsServerError, equals('Error retrieving forecasts'));
      expect(Constants.gatheringCoordinates, equals('Gathering coordinates'));
      expect(Constants.coordRetrieveError, equals('Error getting coordinates'));
      expect(Constants.failedCoordinates, equals('Failed to get coordinates'));
      expect(Constants.clickForMore, equals('View'));
      expect(
          Constants.offlineError, equals('This data is unavailable offline'));
      expect(Constants.invalidError, equals('Invalid data type in cache'));
      expect(Constants.unknownError, equals('Something went wrong'));
      expect(Constants.localUnknownError,
          equals('Something went wrong in local storage'));
      expect(Constants.lostConnection,
          equals('Please check your internet connection.'));
      expect(Constants.connectionTimeout, equals('Request timed out'));
      expect(Constants.degree, equals('\u{00B0}'));
      expect(Constants.inputRadius, equals(8));
      expect(Constants.concertCities, isNotNull);
      expect(Constants.weathersBox, equals('weathers'));
      expect(Constants.forecastsBox, equals('forecasts'));
    },
  );
}
