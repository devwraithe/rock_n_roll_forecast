import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/concerts_list.dart';
import 'package:rock_n_roll_forecast/app/shared/helpers/widget_helper.dart';
import 'package:rock_n_roll_forecast/app/shared/theme/text_theme.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/responsive.dart';

import '../../../../shared/utilities/constants.dart';

class ConcertsScreen extends StatefulWidget {
  const ConcertsScreen({Key? key}) : super(key: key);
  @override
  State<ConcertsScreen> createState() => _ConcertsScreenState();
}

class _ConcertsScreenState extends State<ConcertsScreen> {
  final Map<String, ValueNotifier<bool>> loadingStates = {};
  late TextEditingController searchController;
  List filteredLocations = [];

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredLocations = Constants.concertCities;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchCities(String query) {
    setState(() {
      // Filter concert cities based on the search query
      filteredLocations = Constants.concertCities.where((location) {
        final searchQuery =
            location.city.toLowerCase().contains(query.toLowerCase()) ||
                location.country.toLowerCase().contains(query.toLowerCase());
        return searchQuery;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: isMobile
              ? const EdgeInsets.symmetric(horizontal: 18, vertical: 16)
              : const EdgeInsets.symmetric(horizontal: 46, vertical: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Concerts Cities",
                style: AppTextTheme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: isMobile ? 24 : 34),
              SizedBox(
                width: isMobile ? double.infinity : 0.6.sw,
                child: TextField(
                  controller: searchController,
                  style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                    fontSize: isMobile ? 14.sp : 8.sp,
                  ),
                  decoration: InputDecoration(
                    label: Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "Search for concert cities...",
                        style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  onChanged: _searchCities,
                ),
              ),
              SizedBox(height: isMobile ? 26 : 46),
              filteredLocations.isEmpty
                  ? WidgetHelper.error("Concert city is not found!")
                  : ConcertsList(locations: filteredLocations),
            ],
          ),
        ),
      ),
    );
  }
}
