import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/weather_overview.dart';

void main() {
  const condition = 'Broken Clouds';
  const temperature = '18';
  const feelsLike = 18;
  const humidity = '81';
  const wind = 2;
  const icon = '04d';

  testWidgets(
    'Should build the WeatherOverview widget',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ScreenUtilInit(
          builder: (context, child) {
            return const MaterialApp(
              home: WeatherOverview(
                condition: condition,
                temperature: temperature,
                humidity: humidity,
                icon: icon,
                wind: wind,
                feelsLike: feelsLike,
              ),
            );
          },
        ),
      );

      await tester.pump();

      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Container), findsOneWidget);
    },
  );
}
