import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/helpers/text_sizing_helper.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_info_column.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_info_row.dart';

import '../cubits/forecast/forecast_cubit.dart';

class ConcertInfoScreen extends StatefulWidget {
  const ConcertInfoScreen({super.key});

  @override
  State<ConcertInfoScreen> createState() => _ConcertInfoScreenState();
}

class _ConcertInfoScreenState extends State<ConcertInfoScreen> {
  String? city, image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getWeatherData();
  }

  void getWeatherData() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final result = arguments as Map;
    final latitude = result['coordinates']['latitude'].toString();
    final longitude = result['coordinates']['longitude'].toString();

    city = result['city'];
    image = result['image'];

    context.read<WeatherCubit>().getWeather(latitude, longitude, city!);
    context.read<ForecastCubit>().getForecast(latitude, longitude, city!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive.isMobile
          ? ConcertInfoColumn(
              image: image!,
              city: city!,
            )
          : ConcertInfoRow(
              image: image!,
              city: city!,
            ),
    );
  }
}
