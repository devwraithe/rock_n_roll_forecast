import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/text_sizing_helper.dart';

class OverviewLoader extends StatelessWidget {
  const OverviewLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back,
                color: AppColors.white,
                size: Responsive.isMobile ? 24 : 30,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            "--",
            textAlign: TextAlign.center,
            style: textTheme.displayLarge?.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
