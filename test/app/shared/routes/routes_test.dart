import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/shared/routes/routes.dart';

void main() {
  // test case: should have correct route paths
  test('should have correct route paths', () {
    // assert that the route paths are as expected
    expect(Routes.concerts, '/concerts');
    expect(Routes.concertInfo, '/concert/info');
  });
}
