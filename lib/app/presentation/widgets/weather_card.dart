import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';

class CityCard extends StatefulWidget {
  const CityCard({
    super.key,
    required this.city,
    required this.note,
    required this.time,
    this.onPressed,
  });

  final String city, note, time;
  final Function()? onPressed;

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.city,
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              widget.time,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                widget.note,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
