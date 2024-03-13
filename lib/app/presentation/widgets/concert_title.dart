import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/responsive_helper.dart';

class ConcertTitle extends StatelessWidget {
  const ConcertTitle({
    super.key,
    required this.city,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back,
              color: AppColors.white,
              size: Responsive.isMobile ? 24 : 30,
            ),
            Text(
              city,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: Responsive.isMobile ? 24 : 30),
          ],
        ),
      ),
    );
  }
}
