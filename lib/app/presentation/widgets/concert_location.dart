import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';

class ConcertLocation extends StatelessWidget {
  const ConcertLocation({
    super.key,
    required this.city,
    required this.note,
    required this.country,
    this.onPressed,
  });

  final String city, note, country;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 38),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  country.toLowerCase(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  note.toLowerCase(),
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              city.toLowerCase(),
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
