import 'package:flutter/material.dart';

import '../../core/routes/routes.dart';
import '../../core/utilities/helpers/location_helper.dart';
import '../../core/utilities/helpers/misc_helper.dart';
import '../../domain/entities/city_entity.dart';
import 'city_card.dart';

class ConcertsList extends StatefulWidget {
  const ConcertsList({
    super.key,
    required this.cities,
    required this.loadingStates,
  });

  final List cities;
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
        itemCount: widget.cities.length,
        itemBuilder: (context, index) {
          final city = widget.cities[index];

          return ValueListenableBuilder(
            valueListenable: widget.loadingStates[city.name]!,
            builder: (context, loading, child) {
              return CityCard(
                city: city.name,
                image: city.image,
                note: loading ? "Gathering coordinates" : "Click for more info",
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
