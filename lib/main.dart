import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'app/modules/weather/domain/adapters/forecast_adapter.dart';
import 'app/modules/weather/domain/adapters/weather_adapter.dart';
import 'app/shared/services/di_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injectors
  await di.init();

  // Initialize hive and register adapters - for offline support
  Directory dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.registerAdapter(WeatherAdapter());
  Hive.registerAdapter(ForecastAdapter());

  // Initialize screen utils - for responsiveness
  await ScreenUtil.ensureScreenSize();

  runApp(const RockBand());
}
