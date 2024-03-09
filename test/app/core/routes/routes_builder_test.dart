import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/routes/routes.dart';
import 'package:rock_n_roll_forecast/app/core/routes/routes_builder.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concert_info_screen.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concerts_screen.dart';

void main() {
  // test case: should contain correct routes and widget builders
  test('should contain correct routes and widget builders', () {
    // define the expected routes and their corresponding widget builders
    final expectedRoutes = <String, WidgetBuilder>{
      Routes.concerts: (context) => const ConcertsScreen(),
      Routes.concertInfo: (context) => const ConcertInfoScreen(),
    };

    // assert that the routesBuilder map has the same number of keys as the expectedRoutes map
    expect(routesBuilder.keys.length, equals(expectedRoutes.keys.length));

    // iterate through each entry in routesBuilder
    for (final entry in routesBuilder.entries) {
      final route = entry.key;
      final widgetBuilder = entry.value;

      // assert that the expectedRoutes contains the current route key
      expect(expectedRoutes.containsKey(route), isTrue);

      // assert that the widgetBuilder is of type WidgetBuilder
      expect(widgetBuilder, isA<WidgetBuilder>());

      // assert that the runtime types of widgetBuilder and the corresponding expectedRoutes widget builder match
      expect(
        widgetBuilder.runtimeType,
        equals(
          expectedRoutes[route]!.runtimeType,
        ),
      );

      // additional assertions specific to each route
      if (widgetBuilder == expectedRoutes[Routes.concerts]) {
        final homeScreen = widgetBuilder;
        expect(homeScreen, isA<ConcertsScreen>());
      } else if (widgetBuilder == expectedRoutes[Routes.concertInfo]) {
        final detailScreen = widgetBuilder;
        expect(detailScreen, isA<ConcertInfoScreen>());
      }
    }
  });
}
