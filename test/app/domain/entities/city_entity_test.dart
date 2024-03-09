import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/city_entity.dart';

void main() {
  group('CityEntity', () {
    test('should initialize with the correct values', () {
      // Arrange
      const cityName = 'New York';
      const cityImage = 'assets/images/new_york.jpg';

      // Act
      final cityEntity = CityEntity(name: cityName, image: cityImage);

      // Assert
      expect(cityEntity.name, cityName);
      expect(cityEntity.image, cityImage);
    });

    test('should not be equal if their properties do not match', () {
      // Arrange
      const cityName1 = 'New York';
      const cityImage1 = 'assets/images/new_york.jpg';

      const cityName2 = 'Los Angeles';
      const cityImage2 = 'assets/images/los_angeles.jpg';

      final cityEntity1 = CityEntity(name: cityName1, image: cityImage1);
      final cityEntity2 = CityEntity(name: cityName2, image: cityImage2);

      // Act & Assert
      expect(cityEntity1, isNot(equals(cityEntity2)));
    });
  });
}
