import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/weather_forecast_loader.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  testWidgets(
    'Should show the WeatherForecastLoader',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: WeatherForecastLoader(),
          );
        }),
      );

      await tester.pump();

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(Shimmer), findsWidgets);
      expect(find.byType(Expanded), findsWidgets);
    },
  );
}
