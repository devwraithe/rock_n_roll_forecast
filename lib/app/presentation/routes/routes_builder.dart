import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/presentation/routes/routes.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concert_info_screen.dart';

import '../screens/concerts_screen.dart';

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
