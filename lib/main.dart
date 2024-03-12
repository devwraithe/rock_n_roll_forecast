import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/app.dart';
import 'app/core/utilities/adapters/hive_adapters/forecast_adapter.dart';
import 'app/core/utilities/adapters/hive_adapters/weather_adapter.dart';
import 'app/core/utilities/di_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injectors
  di.init();

  // Initialize hive and register adapters - for offline support
  await Hive.initFlutter();
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(ForecastAdapter());

  // Initialize screen utils - for responsiveness
  await ScreenUtil.ensureScreenSize();

  runApp(const RockAndRoll());
}
