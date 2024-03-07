import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/five_days_forecast/five_days_forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_overview_loading.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/daily_forecast.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/error_card.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/forecast_shimmer.dart';

import '../../core/theme/text_theme.dart';
import '../cubits/five_days_forecast/five_days_forecast_state.dart';
import '../widgets/city_overview.dart';

class ConcertInfoScreen extends StatefulWidget {
  const ConcertInfoScreen({super.key});

  @override
  State<ConcertInfoScreen> createState() => _ConcertInfoScreenState();
}

class _ConcertInfoScreenState extends State<ConcertInfoScreen> {
  String? city;

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

    city = result['city'];

    context.read<WeatherCubit>().getWeather(latitude, longitude, city!);
    context.read<ForecastCubit>().getForecast(latitude, longitude, city!);
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
                BlocBuilder<WeatherCubit, WeatherStates>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const OverviewShimmer();
                    } else if (state is WeatherLoaded) {
                      final weather = state.result;

                      return CityOverview(
                        condition: weather.description,
                        temp: weather.temperature.toString(),
                        location: city!,
                      );
                    } else if (state is WeatherError) {
                      return ErrorCard(errorMessage: state.message);
                    } else {
                      return Text(
                        "Something went wrong",
                        textAlign: TextAlign.center,
                        style: AppTextTheme.textTheme.bodyLarge,
                      );
                    }
                  },
                ),
                const SizedBox(height: 18),
                BlocBuilder<ForecastCubit, ForecastState>(
                  builder: (context, state) {
                    if (state is ForecastLoading) {
                      return const DailyShimmer();
                    } else if (state is ForecastLoaded) {
                      return DailyForecast(forecast: state.result);
                    } else if (state is ForecastError) {
                      return ErrorCard(errorMessage: state.message);
                    } else {
                      return Text(
                        "Something went wrong",
                        textAlign: TextAlign.center,
                        style: AppTextTheme.textTheme.bodyLarge,
                      );
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
