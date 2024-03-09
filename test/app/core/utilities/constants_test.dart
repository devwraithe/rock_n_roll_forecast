import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';

void main() {
  test('Constants should have correct values', () {
    // Test individual constants
    expect(Constants.fontFamily, equals('Satoshi'));
    expect(Constants.serverError, equals('Error retrieving weathers'));
    expect(Constants.offlineError, equals('This data is unavailable offline'));
    expect(Constants.socketError, equals('No Internet Connection'));
    expect(Constants.unknownError, equals('Something went wrong'));
    expect(Constants.lostConnection,
        equals('Please check your internet connection.'));
    expect(Constants.timeout,
        equals('Request timed out. Please try again later.'));
    expect(Constants.degree, equals('\u{00B0}'));
    expect(Constants.unsplashUrl, equals('https://images.unsplash.com'));
    expect(
        Constants.compressor,
        equals(
            '?q=80&w=2275&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'));
    expect(Constants.imageHeight, equals(240));
    expect(Constants.inputRadius, equals(8));
  });
}
