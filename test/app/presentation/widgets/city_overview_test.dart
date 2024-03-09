import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_overview.dart';

void main() {
  group('CityOverview Tests', () {
    testWidgets('Displays location text', (WidgetTester tester) async {
      const location = 'London';

      await tester.pumpWidget(
        ScreenUtilInit(
          builder: (context, child) {
            return const MaterialApp(
              home: CityOverview(
                location: location,
                condition: 'Cloudy',
                temperature: '20',
                humidity: '60',
                pressure: '1013',
              ),
            );
          },
        ),
      );

      await tester.pump();

      final locationText = find.text(location);
      expect(locationText, findsOneWidget);
    });

    testWidgets('Displays temperature with degree symbol', (
      WidgetTester tester,
    ) async {
      const temperature = '25';
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: CityOverview(
              location: 'Paris',
              condition: 'Sunny',
              temperature: temperature,
              humidity: '70',
              pressure: '1015',
            ),
          );
        }),
      );

      await tester.pump();

      final temperatureText = find.text('$temperature${Constants.degree}');
      expect(temperatureText, findsOneWidget);
    });
  });
}
