import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static bool isMobile = ScreenUtil().screenWidth < 600;

  static double displayLarge = isMobile ? 48.sp : 42.sp;
  static double headlineLarge = isMobile ? 20.sp : 20.sp;
  static double headlineMedium = isMobile ? 18.sp : 14.sp;
  static double headlineSmall = isMobile ? 16.sp : 12.sp;
  static double bodyLarge = isMobile ? 14.sp : 10.sp;
  static double bodyMedium = isMobile ? 12.sp : 8.sp;
  static double bodySmall = isMobile ? 10.sp : 6.sp;
}
