import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/current_weather/current_weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/current_weather/current_weather_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/five_days_forecast/five_days_forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/daily_forecast.dart';

import '../cubits/five_days_forecast/five_days_forecast_state.dart';
import '../widgets/city_overview.dart';

class ConcertInfoScreen extends StatefulWidget {
  const ConcertInfoScreen({super.key});

  @override
  State<ConcertInfoScreen> createState() => _ConcertInfoScreenState();
}

class _ConcertInfoScreenState extends State<ConcertInfoScreen> {
  Map<String, double> cityCoordinates = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getCityCoordinates();
  }

  void getCityCoordinates() {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    cityCoordinates = arguments as Map<String, double>;
    debugPrint("City coordinates - $cityCoordinates");
    context.read<CurrentWeatherCubit>().getCurrentWeather(
          cityCoordinates['latitude'].toString(),
          cityCoordinates['longitude'].toString(),
        );
    context.read<FiveDaysForecastCubit>().getFiveDaysForecast(
          cityCoordinates['latitude'].toString(),
          cityCoordinates['longitude'].toString(),
        );
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
                      return const CircularProgressIndicator();
                    } else if (state is CurrentWeatherLoaded) {
                      return Text("Something here - ${state.result}");
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
                CityOverview(
                  condition: "Overcast",
                  temp: "70",
                  location: "Silverstone, UK",
                ),
                const SizedBox(height: 18),
                BlocBuilder<FiveDaysForecastCubit, FiveDaysForecastState>(
                  builder: (context, state) {
                    if (state is FiveDaysForecastLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is FiveDaysForecastLoaded) {
                      return Text("Something here - ${state.result}");
                    } else if (state is FiveDaysForecastError) {
                      return Text("Error here - ${state.message}");
                    } else {
                      return const Text("Something went wrong");
                    }
                  },
                ),
                DailyForecast(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
