import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize screen utils - for responsiveness
  await ScreenUtil.ensureScreenSize();

  runApp(const CloudwalkAssessment());
}
