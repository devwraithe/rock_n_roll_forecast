import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/screens/concert_info_screen.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/screens/concerts_screen.dart';
import 'package:rock_n_roll_forecast/app/shared/routes/routes.dart';
import 'package:rock_n_roll_forecast/app/shared/routes/routes_builder.dart';

import '../helpers/test_helper.mocks.dart';

void main() {
  group('routesController', () {
    test('returns MaterialPageRoute for concerts route', () {
      // Create a mock RouteSettings with the desired name
      final settings = MockRouteSettings();
      when(settings.name).thenReturn(Routes.concerts);

      // Call the routesController function
      final route = routesController(settings);

      // Verify that it returns a MaterialPageRoute with ConcertsScreen
      expect(route, isA<MaterialPageRoute>());
      expect((route as MaterialPageRoute).builder(MockBuildContext()),
          isA<ConcertsScreen>());
    });

    test('returns MaterialPageRoute for concertInfo route', () {
      // Create a mock RouteSettings with the desired name and arguments
      final settings = MockRouteSettings();
      when(settings.name).thenReturn(Routes.concertInfo);
      when(settings.arguments)
          .thenReturn({'example_argument': 'example_value'});

      // Call the routesController function
      final route = routesController(settings);

      // Verify that it returns a MaterialPageRoute with ConcertInfoScreen and arguments
      expect(route, isA<MaterialPageRoute>());
      expect((route as MaterialPageRoute).builder(MockBuildContext()),
          isA<ConcertInfoScreen>());
      expect((route.builder(MockBuildContext()) as ConcertInfoScreen).arguments,
          {'example_argument': 'example_value'});
    });
  });
}
