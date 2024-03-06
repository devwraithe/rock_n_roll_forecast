import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';
import 'app/core/utilities/di_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize dependency injectors
  di.init();
  // initialize screen utils - for responsiveness
  await ScreenUtil.ensureScreenSize();

  runApp(const CloudwalkAssessment());
}
