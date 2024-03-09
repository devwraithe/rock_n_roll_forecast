import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';

void main() {
  group('CacheException', () {
    test('props should contain the provided failure', () {
      // Arrange
      final failure = Failure('Test message');
      final exception = CacheException(failure);

      // Act
      final props = exception.props;

      // Assert
      expect(props, contains(failure));
    });
  });

  group('HiveException', () {
    test('props should contain the provided failure', () {
      // Arrange
      final failure = Failure('Test message');
      final exception = HiveException(failure);

      // Act
      final props = exception.props;

      // Assert
      expect(props, contains(failure));
    });
  });

  group('UnexpectedException', () {
    test('props should contain the provided failure', () {
      // Arrange
      final failure = Failure('Test message');
      final exception = UnexpectedException(failure);

      // Act
      final props = exception.props;

      // Assert
      expect(props, contains(failure));
    });
  });

  group('ServerException', () {
    test('props should contain the provided failure', () {
      // Arrange
      final failure = Failure('Test message');
      final exception = ServerException(failure);

      // Act
      final props = exception.props;

      // Assert
      expect(props, contains(failure));
    });
  });

  group('NetworkException', () {
    test('props should contain the provided failure', () {
      // Arrange
      final failure = Failure('Test message');
      final exception = NetworkException(failure);

      // Act
      final props = exception.props;

      // Assert
      expect(props, contains(failure));
    });
  });
}
