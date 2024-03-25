import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/services/location_service.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/navigation_helper.dart';

import '../../core/utilities/constants.dart';
import '../../domain/entities/location_entity.dart';
import 'concert_location.dart';

class ConcertsList extends StatelessWidget {
  const ConcertsList({
    super.key,
    required this.locations,
    required this.loadingStates,
    required this.locationService,
  });

  final List locations;
  final LocationService locationService;
  final Map<String, ValueNotifier<bool>> loadingStates;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final LocationEntity location = locations[index];

          return ValueListenableBuilder(
            valueListenable:
                loadingStates[location.city] ?? ValueNotifier(false),
            builder: (context, loading, child) {
              return ConcertLocation(
                country: location.country,
                city: location.city,
                note: loading
                    ? Constants.gatheringCoordinates
                    : Constants.clickForMore,
                onPressed: () {
                  const locationService = LocationServiceImpl();

                  NavigationHelper.goToConcertInfo(
                    context,
                    locationService,
                    location,
                    loadingStates,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
