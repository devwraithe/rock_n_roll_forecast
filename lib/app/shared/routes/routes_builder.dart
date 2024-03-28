import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/shared/routes/routes.dart';

import '../../modules/weather/presentation/screens/concert_info_screen.dart';
import '../../modules/weather/presentation/screens/concerts_screen.dart';

Route<dynamic> routesController(RouteSettings settings) {
  switch (settings.name) {
    case Routes.concerts:
      return MaterialPageRoute(
        builder: (context) => const ConcertsScreen(),
      );
    case Routes.concertInfo:
      final arguments = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (context) => ConcertInfoScreen(
          arguments: arguments,
        ),
      );
    default:
      throw ('the specified route is unavailable!');
  }
}
