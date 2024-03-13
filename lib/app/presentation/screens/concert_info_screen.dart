import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_title.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/responsive_helper.dart';
import '../../core/utilities/helpers/widget_helper.dart';
import '../cubits/forecast/forecast_cubit.dart';
import '../cubits/forecast/forecast_state.dart';
import '../cubits/weather/weather_state.dart';
import '../widgets/city_overview_loader.dart';
import '../widgets/daily_forecast.dart';
import '../widgets/forecast_loader.dart';
import '../widgets/weather_overview.dart';

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
    final isMobile = Responsive.isMobile;

    return Scaffold(
      body: Column(
        children: [
          ConcertTitle(city: city!),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 18 : 36,
            ),
            child: Center(
              child: BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const OverviewLoader();
                  } else if (state is WeatherLoaded) {
                    final weather = state.result;

                    return WeatherOverview(
                      icon: weather.iconCode,
                      condition: weather.description,
                      temperature: weather.temperature.toString(),
                      location: city!,
                      humidity: weather.humidity.toString(),
                      wind: weather.wind,
                      feelsLike: weather.feelsLike,
                    );
                  } else if (state is WeatherError) {
                    return WidgetHelper.error(state.message);
                  } else {
                    return WidgetHelper.error(Constants.unknownError);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          BlocBuilder<ForecastCubit, ForecastState>(
            builder: (context, state) {
              if (state is ForecastLoading) {
                return const ForecastLoader();
              } else if (state is ForecastLoaded) {
                return DailyForecast(forecast: state.result);
              } else if (state is ForecastError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: WidgetHelper.error(state.message),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: WidgetHelper.error(
                    Constants.unknownError,
                  ),
                );
              }
            },
          ),
          SizedBox(height: isMobile ? 22 : 42),
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
    );
  }
}
