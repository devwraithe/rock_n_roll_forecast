import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/location_helper.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_card.dart';

import '../../core/routes/routes.dart';

class ConcertsScreen extends StatefulWidget {
  const ConcertsScreen({Key? key}) : super(key: key);

  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  final Map<String, ValueNotifier<bool>> loadingStates = {};
  final Map<String, String> cityTimes =
      {}; // Map to store current time for each city
  late TextEditingController searchController;
  List filteredCities = []; // List to store filtered concert cities

  @override
  void initState() {
    super.initState();
    // Initialize loading states for each city
    for (final city in Constants.concertCities) {
      loadingStates[city] = ValueNotifier<bool>(false);
      _getCurrentTime(city); // Fetch current time for each city
    }
    searchController = TextEditingController();
    filteredCities = Constants.concertCities;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentTime(String city) async {
    try {
      // Fetch current time for the city
      final time = await LocationHelper.getCurrentTimeForCity(city);

      // Format the time as a string
      final formattedTime =
          DateFormat('HH:mm').format(time); // Adjust format as needed

      setState(() {
        cityTimes[city] =
            formattedTime; // Update cityTimes map with formatted time
      });
    } catch (e) {
      print('Error fetching time for $city: $e');
    }
  }

  Future<void> _getCoordinates(String city) async {
    loadingStates[city]?.value = true;

    final coordinates = await LocationHelper.cityCoordinates(city);
    debugPrint("Coordinates - $coordinates");

    loadingStates[city]?.value = false;

    _goToConcertInfo(coordinates);
  }

  void _goToConcertInfo(Map<String, double> coordinates) {
    Navigator.pushNamed(
      context,
      Routes.concertInfo,
      arguments: coordinates,
    );
  }

  void _searchConcerts(String query) {
    setState(() {
      // Filter concert cities based on the search query
      filteredCities = Constants.concertCities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();

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
          child: SingleChildScrollView(
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
                  decoration: InputDecoration(
                    hintText: 'Search concerts...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _searchConcerts,
                ),
                const SizedBox(height: 10),
                // Use ListView.builder to create items dynamically
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = filteredCities[index];
                    final time = cityTimes[city] ??
                        'Unknown'; // Get current time for the city

                    return ValueListenableBuilder(
                      valueListenable: loadingStates[city]!,
                      builder: (context, loading, child) {
                        return CityCard(
                          city: city,
                          time: time, // Pass current time to CityCard
                          note: loading
                              ? "Gathering coordinates"
                              : "Tap to get weather info",
                          onPressed: () => _getCoordinates(city),
                        );
                      },
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
