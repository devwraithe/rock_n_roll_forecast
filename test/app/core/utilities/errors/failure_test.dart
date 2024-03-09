import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';

void main() {
  group('Failure', () {
    test('props should contain the message', () {
      // Arrange
      final failure = Failure('Test message');

      // Act
      final props = failure.props;

      // Assert
      expect(props, contains('Test message'));
    });

    test('props should not contain other messages', () {
      // Arrange
      final failure = Failure('Test message');

      // Act
      final props = failure.props;

      // Assert
      expect(props, isNot(contains('Other message')));
    });
  });
}