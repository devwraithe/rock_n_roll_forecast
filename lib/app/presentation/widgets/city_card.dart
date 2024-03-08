import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_sizing_helper.dart';

class CityCard extends StatelessWidget {
  const CityCard({
    super.key,
    required this.city,
    required this.note,
    required this.image,
    this.onPressed,
  });

  final String city, note, image;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkGray,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(bottom: 18),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: image,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 0),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.isMobile ? 16 : 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city,
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      note,
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
