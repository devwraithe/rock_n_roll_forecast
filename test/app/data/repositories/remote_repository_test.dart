import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/exceptions.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/errors/failure.dart';
import 'package:rock_n_roll_forecast/app/data/models/weather_model.dart';
import 'package:rock_n_roll_forecast/app/data/repositories/remote_repository_impl.dart';
import 'package:rock_n_roll_forecast/app/domain/repositories/remote_repository.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  const String lat = 'lat';
  const String lon = 'lon';
  const String city = 'Silverstone, UK';

  late WeatherRemoteRepository weatherRepository;
  late MockWeatherRemoteDatasource mockWeatherRemoteDatasource;

  setUp(() {
    mockWeatherRemoteDatasource = MockWeatherRemoteDatasource();

    weatherRepository = WeatherRemoteRepositoryImpl(
      mockWeatherRemoteDatasource,
    );
  });

  group('should run tests for WeatherRemoteRepositoryImpl', () {
    final weatherJson = json.encode({
      "coord": {"lat": 37.7749, "lon": -122.4194},
      "weather": [
        {"main": "Clear", "description": "clear sky", "icon": "01d"}
      ],
      "main": {"temp": 25.6, "pressure": 1013, "humidity": 60}
    });
    final weatherModel = WeatherModel.fromJson(json.decode(weatherJson));

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(mockWeatherRemoteDatasource.getWeather(lat, lon)).thenAnswer(
          (_) async => weatherModel,
        );
        // act
        final result = await weatherRepository.getWeather(lat, lon);
        // assert
        verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
        expect(result, equals(Right(weatherModel.toEntity())));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockWeatherRemoteDatasource..getWeather(lat, lon))
            .thenThrow(ServerException(Failure(Constants.serverError)));
        // act
        final result = await weatherRepository.getWeather(lat, lon);
        // assert
        verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
        expect(result, equals(Left(Failure(Constants.serverError))));
        expect(result.isLeft(), true);
      },
    );

    test(
      'should return network failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockWeatherRemoteDatasource..getWeather(lat, lon))
            .thenThrow(NetworkException(Failure(Constants.lostConnection)));
        // act
        final result = await weatherRepository.getWeather(lat, lon);
        // assert
        verify(mockWeatherRemoteDatasource.getWeather(lat, lon));
        expect(result, equals(Left(Failure(Constants.lostConnection))));
        expect(result.isLeft(), true);
      },
    );
  });
}
