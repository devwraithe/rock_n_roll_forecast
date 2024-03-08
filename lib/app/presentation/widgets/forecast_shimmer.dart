import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/widget_helper.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/text_sizing_helper.dart';

class ForecastLoader extends StatelessWidget {
  const ForecastLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile ? 18 : 36,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetHelper.forecastTitle(),
          const SizedBox(height: 14),
          for (int i = 0; i <= 5; i++)
            Container(
              padding: EdgeInsets.symmetric(
                vertical: Responsive.isMobile ? 10 : 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: shimmer(),
                  ),
                  SizedBox(width: Responsive.isMobile ? 16 : 32),
                  Expanded(
                    flex: 1,
                    child: shimmer(),
                  ),
                  SizedBox(width: Responsive.isMobile ? 16 : 32),
                  Expanded(
                    flex: 4,
                    child: shimmer(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.lightGray,
      child: Container(
        height: Responsive.isMobile ? 50 : 80,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
