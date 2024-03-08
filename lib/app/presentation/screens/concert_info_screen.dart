import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_overview_loading.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/daily_forecast.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/error_card.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/forecast_shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../cubits/forecast/forecast_cubit.dart';
import '../cubits/forecast/forecast_state.dart';
import '../widgets/city_overview.dart';

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
    getCityCoordinates();
  }

  void getCityCoordinates() {
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
    final imageHeight = 380.0.sp;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: image!,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 0),
                ),
                Container(
                  width: double.infinity,
                  color: AppColors.black.withOpacity(0.65),
                  height: imageHeight,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: BlocBuilder<WeatherCubit, WeatherStates>(
                      builder: (context, state) {
                        if (state is WeatherLoading) {
                          return const OverviewLoading();
                        } else if (state is WeatherLoaded) {
                          final weather = state.result;

                          return CityOverview(
                            condition: weather.description,
                            temperature: weather.temperature.toString(),
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
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            BlocBuilder<ForecastCubit, ForecastState>(
              builder: (context, state) {
                if (state is ForecastLoading) {
                  return const ForecastLoader();
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
            const SizedBox(height: 22),
            Text(
              "Forecast for $city",
              style: AppTextTheme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
