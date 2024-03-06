import 'package:flutter/material.dart';
import 'package:rock_n_roll_forecast/app/core/routes/routes.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concert_info_screen.dart';

import '../../presentation/screens/concerts_screen.dart';

final routesBuilder = <String, WidgetBuilder>{
  Routes.concerts: (context) => const ConcertsScreen(),
  Routes.concertInfo: (context) => const ConcertInfoScreen(),
};
