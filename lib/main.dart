import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/app.dart';
import 'app/core/utilities/adapters/current_weather_adapter.dart';
import 'app/core/utilities/di_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize dependency injectors
  di.init();

  // initialize hive and register adapters - for offline support
  await Hive.initFlutter();
  Hive.registerAdapter(CurrentWeatherEntityAdapter());

  // initialize screen utils - for responsiveness
  await ScreenUtil.ensureScreenSize();

  runApp(const CloudwalkAssessment());
}
