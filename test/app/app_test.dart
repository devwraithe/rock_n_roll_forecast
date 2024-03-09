import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/di_service.dart' as di;
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concerts_screen.dart';

void main() {
  // initialize the dependency injector
  di.init();

  testWidgets('should build the app', (WidgetTester tester) async {
    // pump the widget tree
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            // create the WeatherCubit using the dependency injector
            create: (_) => di.sl<WeatherCubit>(),
          ),
          BlocProvider<ForecastCubit>(
            // create the ForecastCubit using the dependency injector
            create: (_) => di.sl<ForecastCubit>(),
          ),
        ],
        child: ScreenUtilInit(
          builder: (context, child) {
            return const MaterialApp(
              home: ConcertsScreen(),
            );
          },
        ),
      ),
    );
  });
}
