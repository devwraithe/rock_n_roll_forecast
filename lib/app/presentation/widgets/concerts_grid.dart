import 'package:flutter/material.dart';

import '../../core/routes/routes.dart';
import '../../core/utilities/constants.dart';
import '../../core/utilities/helpers/location_helper.dart';
import '../../core/utilities/helpers/misc_helper.dart';
import '../../domain/entities/city_entity.dart';
import 'city_card.dart';

class ConcertsGrid extends StatefulWidget {
  const ConcertsGrid({
    super.key,
    required this.cities,
    required this.loadingStates,
  });

  final List cities;
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
        itemCount: widget.cities.length,
        itemBuilder: (context, index) {
          final city = widget.cities[index];

          return ValueListenableBuilder(
            valueListenable: widget.loadingStates[city.name]!,
            builder: (context, loading, child) {
              return CityCard(
                city: city.name,
                image: city.image,
                note: loading
                    ? Constants.gatheringCoordinates
                    : Constants.clickForMore,
                onPressed: () => _getCoordinates(city),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _getCoordinates(CityEntity city) async {
    final hasInternet = await MiscHelper.hasInternetConnection();

    widget.loadingStates[city.name]?.value = true;

    if (hasInternet) {
      final coordinates = await LocationHelper.cityCoordinates(city.name);
      _goToConcertInfo(coordinates, city);
    } else {
      _goToConcertInfo({}, city);
    }

    widget.loadingStates[city.name]?.value = false;
  }

  void _goToConcertInfo(Map<String, double> coordinates, CityEntity city) {
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
}
