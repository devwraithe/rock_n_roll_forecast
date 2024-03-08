import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';

class DailyShimmer extends StatelessWidget {
  const DailyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "5-DAYS FORECAST",
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.black,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          for (int i = 0; i <= 5; i++)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: shimmer(),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: shimmer(),
                  ),
                  const SizedBox(width: 10),
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
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
