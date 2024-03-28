import 'package:flutter/material.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/text_theme.dart';
import '../../../../shared/utilities/helpers/responsive_helper.dart';

class ConcertTitle extends StatelessWidget {
  const ConcertTitle({
    super.key,
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: Responsive.isMobile ? 24 : 30,
          ),
        ),
        Text(
          city,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: Responsive.isMobile ? 24 : 30),
      ],
    );
  }
}
