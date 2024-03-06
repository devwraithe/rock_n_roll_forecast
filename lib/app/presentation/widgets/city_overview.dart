import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_helper.dart';

import '../../core/theme/text_theme.dart';
import '../../core/utilities/constants.dart';

class CityOverview extends StatelessWidget {
  const CityOverview({
    super.key,
    required this.location,
    required this.condition,
    required this.temp,
  });

  final String condition, temp, location;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.textTheme;

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            location,
            style: textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          Text(
            "$temp${Constants.degree}",
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 4),
          Text(
            TextHelper.capitalizeLetter(condition),
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          // Text(
          //   currentDate(),
          //   style: textTheme.bodyMedium,
          // ),
        ],
      ),
    );
  }
}
