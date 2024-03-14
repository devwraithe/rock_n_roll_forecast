import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_title.dart';

void main() {
  // Arrange
  const String city = 'Melbourne';

  testWidgets(
    'Should build ConcertTitle widget',
    (WidgetTester tester) async {
      // Build
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: Scaffold(
              body: ConcertTitle(
                city: city,
              ),
            ),
          );
        }),
      );

      await tester.pump();

      // Verify that the provided text widgets are present in the widget tree
      expect(find.text(city), findsOneWidget);

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    },
  );

  testWidgets(
    'Should pop the navigator button pops the navigator',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: ConcertTitle(
              city: city,
            ),
          );
        }),
      );

      await tester.pump();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
    },
  );
}
