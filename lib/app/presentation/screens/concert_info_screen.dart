import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/current_weather/current_weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/current_weather/current_weather_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/five_days_forecast/five_days_forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_overview_loading.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/daily_forecast.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/forecast_shimmer.dart';

import '../cubits/five_days_forecast/five_days_forecast_state.dart';
import '../widgets/city_overview.dart';

class ConcertInfoScreen extends StatefulWidget {
  const ConcertInfoScreen({super.key});

  @override
  State<ConcertInfoScreen> createState() => _ConcertInfoScreenState();
}

class _ConcertInfoScreenState extends State<ConcertInfoScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCityCoordinates();
  }

  void getCityCoordinates() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final result = arguments as Map;
    final latitude = result['coordinates']['latitude'].toString();
    final longitude = result['coordinates']['longitude'].toString();
    // city = result['city'];
    context
        .read<CurrentWeatherCubit>()
        .getCurrentWeather(lat: latitude, lon: longitude);
    context
        .read<FiveDaysForecastCubit>()
        .getFiveDaysForecast(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          // Overlay
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 60,
            ),
            child: Column(
              children: [
                BlocBuilder<CurrentWeatherCubit, CurrentWeatherStates>(
                  builder: (context, state) {
                    if (state is CurrentWeatherLoading) {
                      return const OverviewShimmer();
                    } else if (state is CurrentWeatherLoaded) {
                      final weather = state.result;

                      return CityOverview(
                        condition: weather.description,
                        temp: weather.temperature.toString(),
                        location: "Gundabad",
                      );
                    } else if (state is CurrentWeatherError) {
                      return Text("Error here - ${state.message}");
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
                const SizedBox(height: 18),
                BlocBuilder<FiveDaysForecastCubit, FiveDaysForecastState>(
                  builder: (context, state) {
                    if (state is FiveDaysForecastLoading) {
                      return const DailyShimmer();
                    } else if (state is FiveDaysForecastLoaded) {
                      return DailyForecast(forecast: state.result);
                    } else if (state is FiveDaysForecastError) {
                      return Text("Error here - ${state.message}");
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
