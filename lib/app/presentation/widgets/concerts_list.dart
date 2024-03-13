import 'package:flutter/material.dart';

import '../../core/routes/routes.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/helpers/location_helper.dart';
import '../../core/utilities/helpers/misc_helper.dart';
import '../../domain/entities/location_entity.dart';
import 'concert_location.dart';

class ConcertsList extends StatefulWidget {
  const ConcertsList({
    super.key,
    required this.locations,
    required this.loadingStates,
  });

  final List locations;
  final Map<String, ValueNotifier<bool>> loadingStates;

  @override
  State<ConcertsList> createState() => _ConcertsListState();
}

class _ConcertsListState extends State<ConcertsList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.locations.length,
        itemBuilder: (context, index) {
          final LocationEntity location = widget.locations[index];

          return ValueListenableBuilder(
            valueListenable: widget.loadingStates[location.city]!,
            builder: (context, loading, child) {
              return ConcertLocation(
                country: location.country,
                city: location.city,
                note: loading
                    ? Constants.gatheringCoordinates
                    : Constants.clickForMore,
                onPressed: () => _getCoordinates(location),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _getCoordinates(LocationEntity location) async {
    final hasInternet = await MiscHelper.hasInternetConnection();
    widget.loadingStates[location.city]?.value = true;

    if (hasInternet) {
      final coordinates = await LocationHelper.cityCoordinates(
        "${location.city}, ${location.country}",
      );
      _goToConcertInfo(coordinates, location);
    } else {
      _goToConcertInfo({}, location);
    }

    widget.loadingStates[location.city]?.value = false;
  }

  void _goToConcertInfo(
    Map<String, double> coordinates,
    LocationEntity location,
  ) {
    Navigator.pushNamed(
      context,
      Routes.concertInfo,
      arguments: {
        'coordinates': coordinates,
        'location': "${location.city}, ${location.country}",
      },
    );
  }
}
