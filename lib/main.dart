import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'app/modules/weather/domain/adapters/forecast_adapter.dart';
import 'app/modules/weather/domain/adapters/weather_adapter.dart';
import 'app/shared/services/di_service.dart' as di;
import 'app/shared/utilities/env_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load and init environment variables
  const baseUrl = String.fromEnvironment("BASE_URL");
  const appId = String.fromEnvironment("APP_ID");

  EnvConfig.initialize(baseUrl: baseUrl, appId: appId);

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
