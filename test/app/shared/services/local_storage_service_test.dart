import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/shared/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/shared/services/local_storage_service.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  late LocalStorageService localStorageService;
  late MockHiveService mockHiveService;
  late MockBox mockBox;

  setUp(() {
    mockBox = MockBox();
    mockHiveService = MockHiveService();
    localStorageService = LocalStorageServiceImpl(mockHiveService);
  });

  const boxName = 'testBox';
  final data = {'key': 'value'};
  const city = 'Melbourne, Australia';
  final mockWeather = MockWeatherEntity();

  test("Should cache to offline storage successfully", () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);

    // Act
    await localStorageService.cacheRequest(boxName, data, city);

    // Assert
    verify(mockHiveService.openBox(boxName)).called(1);
    verify(mockBox.put(city, data)).called(1);
    verify(mockBox.close()).called(1);
  });

  test('should throw CacheException when HiveError occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.put(any, any)).thenThrow(HiveError('Hive error'));

    // Act
    final result = localStorageService.cacheRequest(boxName, data, city);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should rethrow CacheException', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.put(any, any))
        .thenThrow(const CacheException(Failure("Error")));

    // Act
    final result = localStorageService.cacheRequest(boxName, data, city);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when Exception occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.put(any, any)).thenThrow(Exception('Exception error'));

    // Act
    final result = localStorageService.cacheRequest(boxName, data, city);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should return cached data when available', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.containsKey(city)).thenReturn(true);
    when(mockBox.get(city)).thenReturn(mockWeather);

    // Act
    final result = await localStorageService.getRequest(boxName, city);

    // Assert
    expect(result, equals(mockWeather));
  });

  test('should throw CacheException when data is not available', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.containsKey(city)).thenReturn(false);

    // Act
    final result = localStorageService.getRequest(boxName, city);

    // Act & Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when HiveError occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.containsKey(city)).thenReturn(true);
    when(mockBox.get(any)).thenThrow(HiveError('Hive error'));

    // Act
    final result = localStorageService.getRequest(boxName, city);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should rethrow CacheException', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.containsKey(city)).thenReturn(true);
    when(mockBox.get(any)).thenThrow(const CacheException(Failure("Error")));

    // Act
    final result = localStorageService.getRequest(boxName, city);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });

  test('should throw CacheException when Exception occurs', () async {
    // Arrange
    when(mockHiveService.openBox(boxName)).thenAnswer((_) async => mockBox);
    when(mockBox.containsKey(city)).thenReturn(true);
    when(mockBox.get(any)).thenThrow(Exception("Exception Error"));

    // Act
    final result = localStorageService.getRequest(boxName, city);

    // Assert
    expect(() => result, throwsA(isA<CacheException>()));
  });
}
