import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_card.dart';

class ConcertsScreen extends StatefulWidget {
  const ConcertsScreen({super.key});

  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upcoming Concerts",
                  style: AppTextTheme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                for (final city in Constants.concertCities)
                  WeatherCard(
                    city: city,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
