import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/weather_forecast.dart';

void main() {
  const forecastEntity = ForecastEntity(
    dailyTime: 1615093200,
    dailyMinTemp: 20,
    dailyMaxTemp: 30,
    dailyIcon: '04n',
  );

  testWidgets(
    'WeatherForecast widget displays forecast correctly',
    (WidgetTester tester) async {
      final List<ForecastEntity> mockForecast = [
        forecastEntity,
      ];

      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return MaterialApp(
            home: Scaffold(
              body: WeatherForecast(
                forecast: mockForecast,
              ),
            ),
          );
        }),
      );

      await tester.pumpAndSettle();

      expect(find.byType(WeatherForecast), findsOneWidget);

      // Verify that the forecast days are displayed
      expect(find.text('Sunday'), findsOneWidget);
    },
  );
}
