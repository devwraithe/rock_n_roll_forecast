import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/screens/concerts_screen.dart';
import 'package:rock_n_roll_forecast/app/shared/routes/routes_builder.dart';

import 'shared/theme/app_theme.dart';
import 'shared/utilities/di_service.dart';

class RockAndRoll extends StatelessWidget {
  const RockAndRoll({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<WeatherCubit>()),
        BlocProvider(create: (_) => sl<ForecastCubit>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          ScreenUtil.init(context);
          return MaterialApp(
            title: 'Rock And Roll',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            themeMode: ThemeMode.dark,
            home: const ConcertsScreen(),
            onGenerateRoute: routesController,
          );
        },
        child: const ConcertsScreen(),
      ),
    );
  }
}
