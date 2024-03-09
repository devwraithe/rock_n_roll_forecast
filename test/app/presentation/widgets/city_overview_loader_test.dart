import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_overview_loader.dart';

void main() {
  group('OverviewLoader Tests', () {
    testWidgets('Displays loading dash text', (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: OverviewLoader(),
          );
        }),
      );

      await tester.pump();

      final loadingText = find.text('--');
      expect(loadingText, findsOneWidget);
    });

    testWidgets('Back button pops the navigator', (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: OverviewLoader(),
          );
        }),
      );

      await tester.pump();

      final backButton = find.byIcon(Icons.arrow_back);
      await tester.tap(backButton);
      await tester.pumpAndSettle();
    });
  });
}
