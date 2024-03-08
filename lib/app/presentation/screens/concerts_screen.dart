import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/location_helper.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/misc_helper.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/city_entity.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_card.dart';

import '../../core/routes/routes.dart';

class ConcertsScreen extends StatefulWidget {
  const ConcertsScreen({Key? key}) : super(key: key);

  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  final Map<String, ValueNotifier<bool>> loadingStates = {};
  late TextEditingController searchController;
  List filteredCities = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredCities = Constants.concertCities;

    // Initialize loading states for each city
    for (final city in Constants.concertCities) {
      loadingStates[city.name] = ValueNotifier<bool>(false);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _getCoordinates(CityEntity city) async {
    loadingStates[city]?.value = true;

    if (await MiscHelper.hasInternetConnection() == true) {
      final coordinates = await LocationHelper.cityCoordinates(city.name);
      _goToConcertInfo(coordinates, city);
    } else {
      _goToConcertInfo({}, city);
    }

    loadingStates[city]?.value = false;
  }

  void _goToConcertInfo(
    Map<String, double> coordinates,
    CityEntity city,
  ) {
    Navigator.pushNamed(
      context,
      Routes.concertInfo,
      arguments: {
        'coordinates': coordinates,
        'city': city.name,
        'image': city.image,
      },
    );
  }

  void _searchCities(String query) {
    setState(() {
      // Filter concert cities based on the search query
      filteredCities = Constants.concertCities.where((city) {
        return city.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // Reset the loading states for each city
      for (final city in Constants.concertCities) {
        loadingStates[city]?.value = false;
      }
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upcoming Concerts",
                style: AppTextTheme.textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              // Search field
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search Cities',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: _searchCities,
              ),
              const SizedBox(height: 20),
              for (final city in filteredCities)
                ValueListenableBuilder(
                  valueListenable: loadingStates[city.name]!,
                  builder: (context, loading, child) {
                    return CityCard(
                      city: city.name,
                      image: city.image,
                      note: loading
                          ? "Gathering coordinates"
                          : "Click for more info",
                      onPressed: () => _getCoordinates(city),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
