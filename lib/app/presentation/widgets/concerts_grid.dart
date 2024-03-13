import 'package:flutter/material.dart';

import '../../core/routes/routes.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/helpers/location_helper.dart';
import '../../core/utilities/helpers/misc_helper.dart';
import '../../domain/entities/location_entity.dart';
import 'city_card.dart';

class ConcertsGrid extends StatefulWidget {
  const ConcertsGrid({
    super.key,
    required this.locations,
    required this.loadingStates,
  });

  final List locations;
  final Map<String, ValueNotifier<bool>> loadingStates;

  @override
  State<ConcertsGrid> createState() => _ConcertsGridState();
}

class _ConcertsGridState extends State<ConcertsGrid> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 36,
          mainAxisSpacing: 22,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: widget.locations.length,
        itemBuilder: (context, index) {
          final location = widget.locations[index];

          return ValueListenableBuilder(
            valueListenable: widget.loadingStates[location.city]!,
            builder: (context, loading, child) {
              return CityCard(
                city: location.city,
                image: location.image,
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
      final coordinates = await LocationHelper.cityCoordinates(location.city);
      _goToConcertInfo(coordinates, location);
    } else {
      _goToConcertInfo({}, location);
    }

    widget.loadingStates[location.city]?.value = false;
  }

  void _goToConcertInfo(
      Map<String, double> coordinates, LocationEntity location) {
    Navigator.pushNamed(
      context,
      Routes.concertInfo,
      arguments: {
        'coordinates': coordinates,
        'city': location.city,
        'image': location.city,
      },
    );
  }
}
