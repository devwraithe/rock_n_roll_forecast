import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static bool isMobile = ScreenUtil().screenWidth < 600;

  static double displayLarge = isMobile ? 48.sp : 38.sp;
  static double headlineLarge = isMobile ? 24.sp : 18.sp;
  static double headlineMedium = isMobile ? 20.sp : 12.sp;
  static double headlineSmall = isMobile ? 18.sp : 14.sp;
  static double bodyLarge = isMobile ? 16.sp : 10.sp;
  static double bodyMedium = isMobile ? 14.sp : 8.sp;
  static double bodySmall = isMobile ? 12.sp : 8.sp;
}
