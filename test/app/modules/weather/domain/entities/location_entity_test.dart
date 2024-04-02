import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/location_entity.dart';

void main() {
  test('Should initialize with the correct values', () {
    const city = 'Melbourne';
    const country = 'Australia';

    const location = LocationEntity(
      city: city,
      country: country,
    );

    expect(location.city, city);
    expect(location.country, country);
  });

  test('should not be equal if their properties do not match', () {
    const city1 = 'Melbourne';
    const country1 = 'Australia';

    const city2 = 'Monte Carlo';
    const country2 = 'Monaco';

    const location1 = LocationEntity(city: city1, country: country1);
    const location2 = LocationEntity(city: city2, country: country2);

    expect(location1, isNot(equals(location2)));
  });
}
