import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_card.dart';

import '../../core/routes/routes.dart';
import '../../core/utilities/helpers/location_helper.dart';

class ConcertsScreen extends StatefulWidget {
  const ConcertsScreen({super.key});

  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  final ValueNotifier loading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  Future _getCoordinates(String city) async {
    loading.value = true;

    final coordinates = await LocationHelper.cityCoordinates(city);
    debugPrint("Coordinates - $coordinates");

    loading.value = false;

    _goToConcertInfo(coordinates);
  }

  void _goToConcertInfo(Map<String, double> coordinates) {
    Navigator.pushNamed(
      context,
      Routes.concertInfo,
      arguments: coordinates,
    );
  }

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
                  ValueListenableBuilder(
                    valueListenable: loading,
                    builder: (context, _, child) {
                      return CityCard(
                        city: city,
                        note: loading.value == true
                            ? "Gathering coordinates"
                            : "Tap to get weather info",
                        onPressed: () => _getCoordinates(city),
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
