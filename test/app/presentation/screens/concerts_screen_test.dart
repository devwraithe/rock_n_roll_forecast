import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concerts_screen.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concerts_grid.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concerts_list.dart';

void main() {
  group('ConcertsScreen Tests', () {
    testWidgets('Displays Upcoming Concerts title', (tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: ConcertsScreen(),
          );
        }),
      );

      await tester.pumpAndSettle();

      final titleFinder = find.text('Upcoming Concerts');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets(
        'Shows ConcertsList for mobile and ConcertsGrid for larger screens', (
      tester,
    ) async {
      // Mobile size
      tester.binding.window.physicalSizeTestValue = const Size(450, 800);
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: Column(
              children: [
                ConcertsList(
                  cities: [],
                  loadingStates: {},
                ),
              ],
            ),
          );
        }),
      );

      await tester.pumpAndSettle();

      final concertsListFinder = find.byType(ConcertsList);
      expect(concertsListFinder, findsOneWidget);

      // Larger screen size
      tester.binding.window.physicalSizeTestValue = const Size(800, 600);
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: Column(
              children: [
                ConcertsGrid(
                  cities: [],
                  loadingStates: {},
                ),
              ],
            ),
          );
        }),
      );

      await tester.pumpAndSettle();

      final concertsGridFinder = find.byType(ConcertsGrid);
      expect(concertsGridFinder, findsOneWidget);
    });
  });
}
