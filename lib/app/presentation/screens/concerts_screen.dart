import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rock_n_roll_forecast/app/core/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_sizing_helper.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concerts_list.dart';

import '../widgets/concerts_grid.dart';

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

  void _searchCities(String query) {
    setState(() {
      // Filter concert cities based on the search query
      filteredCities = Constants.concertCities.where((city) {
        return city.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      // Reset the loading states for each city
      for (final city in Constants.concertCities) {
        loadingStates[city.name]?.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Responsive.isMobile
              ? const EdgeInsets.symmetric(horizontal: 18, vertical: 16)
              : const EdgeInsets.symmetric(horizontal: 42, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Upcoming Concerts",
                style: AppTextTheme.textTheme.headlineMedium,
              ),
              SizedBox(height: Responsive.isMobile ? 20 : 36),
              // Search field
              SizedBox(
                width: Responsive.isMobile ? double.infinity : 0.6.sw,
                child: TextField(
                  controller: searchController,
                  style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                    fontSize: Responsive.isMobile ? 14.sp : 8.sp,
                  ),
                  decoration: InputDecoration(
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "Search concert cities...",
                        style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  onChanged: _searchCities,
                ),
              ),
              SizedBox(height: Responsive.isMobile ? 26 : 48),
              Responsive.isMobile
                  ? ConcertsList(
                      cities: filteredCities,
                      loadingStates: loadingStates,
                    )
                  : ConcertsGrid(
                      cities: filteredCities,
                      loadingStates: loadingStates,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
