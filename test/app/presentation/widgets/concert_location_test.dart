import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_location.dart';

void main() {
  testWidgets(
    'Should build ConcertLocation widget',
    (WidgetTester tester) async {
      // Arrange
      const String city = 'Melbourne';
      const String note = 'View';
      const String country = 'Australia';

      // Build the ConcertLocation widget
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: Scaffold(
              body: ConcertLocation(
                city: city,
                note: note,
                country: country,
              ),
            ),
          );
        }),
      );

      await tester.pump();

      // Verify that the provided text widgets are present in the widget tree
      expect(find.text(city.toLowerCase()), findsOneWidget);
      expect(find.text(note.toLowerCase()), findsOneWidget);
      expect(find.text(country.toLowerCase()), findsOneWidget);

      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    },
  );
}
