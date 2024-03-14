import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/core/routes/routes_builder.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/di_service.dart' as di;
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concerts_screen.dart';

void main() {
  testWidgets('Should build RockAndRoll widget', (WidgetTester tester) async {
    di.init();

    // pump the widget tree
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(create: (_) => di.sl<WeatherCubit>()),
          BlocProvider<ForecastCubit>(create: (_) => di.sl<ForecastCubit>()),
        ],
        child: ScreenUtilInit(
          builder: (context, child) {
            ScreenUtil.init(context);
            return MaterialApp(
              theme: AppTheme.theme,
              home: const ConcertsScreen(),
              onGenerateRoute: routesController,
            );
          },
        ),
      ),
    );

    // Verify
    expect(find.byType(MultiBlocProvider), findsOneWidget);
    expect(find.byType(ScreenUtilInit), findsOneWidget);
  });
}
