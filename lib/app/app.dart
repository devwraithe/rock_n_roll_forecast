import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rock_n_roll_forecast/app/core/routes/routes_builder.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concerts_screen.dart';

import 'core/theme/app_theme.dart';

class CloudwalkAssessment extends StatelessWidget {
  const CloudwalkAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return MaterialApp(
          title: 'Cloudwalk Assessment',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          themeMode: ThemeMode.light,
          home: const ConcertsScreen(),
          routes: routesBuilder,
        );
      },
      child: const ConcertsScreen(),
    );
  }
}
