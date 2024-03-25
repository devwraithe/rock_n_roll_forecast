import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concerts_screen.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concerts_list.dart';

void main() {
  testWidgets(
    'Should show ConcertsScreen widget',
    (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          builder: (context, child) {
            return const MaterialApp(
              home: Scaffold(
                body: ConcertsScreen(),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Concerts Cities"), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(ConcertsList), findsOneWidget);
    },
  );
}
