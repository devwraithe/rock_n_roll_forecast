import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/helpers/navigation_helper.dart';

import '../../../../shared/utilities/constants.dart';
import '../../domain/entities/location_entity.dart';
import 'concert_location.dart';

class ConcertsList extends StatelessWidget {
  const ConcertsList({
    super.key,
    required this.locations,
  });

  final List locations;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final LocationEntity location = locations.elementAt(index);

          return ConcertLocation(
            country: location.country,
            city: location.city,
            note: Constants.clickForMore,
            onPressed: () {
              NavigationHelper.goToConcertInfo(
                context,
                location,
              );
            },
          );
        },
      ),
    );
  }
}
