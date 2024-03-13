import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/responsive_helper.dart';

class WeatherOverviewLoader extends StatelessWidget {
  const WeatherOverviewLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "--",
          textAlign: TextAlign.center,
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 38),
        Shimmer.fromColors(
          baseColor: AppColors.grey,
          highlightColor: AppColors.lightGray,
          child: Container(
            height: Responsive.isMobile ? 80 : 80,
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
