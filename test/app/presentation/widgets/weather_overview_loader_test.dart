import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/weather_overview_loader.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  group(
    'Should run tests for WeatherOverviewLoader',
    () {
      testWidgets(
        'Should show the WeatherOverviewLoader',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            ScreenUtilInit(builder: (context, child) {
              return const MaterialApp(
                home: WeatherOverviewLoader(),
              );
            }),
          );

          await tester.pump();

          expect(find.text('--'), findsOneWidget);
          expect(find.byType(Shimmer), findsOneWidget);
        },
      );
    },
  );
}
