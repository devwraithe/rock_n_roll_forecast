import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/core/theme/app_colors.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/constants.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_title.dart';

import '../../core/theme/text_theme.dart';
import '../../core/utilities/helpers/responsive_helper.dart';
import '../../core/utilities/helpers/widget_helper.dart';
import '../cubits/forecast/forecast_cubit.dart';
import '../cubits/forecast/forecast_state.dart';
import '../cubits/weather/weather_state.dart';
import '../widgets/weather_forecast.dart';
import '../widgets/weather_forecast_loader.dart';
import '../widgets/weather_overview.dart';
import '../widgets/weather_overview_loader.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 18 : 36),
          child: Column(
            children: [
              ConcertTitle(city: city!),
              const SizedBox(height: 26),
              BlocBuilder<WeatherCubit, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const WeatherOverviewLoader();
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
              const SizedBox(height: 32),
              BlocBuilder<ForecastCubit, ForecastState>(
                builder: (context, state) {
                  if (state is ForecastLoading) {
                    return const WeatherForecastLoader();
                  } else if (state is ForecastLoaded) {
                    return WeatherForecast(forecast: state.result);
                  } else if (state is ForecastError) {
                    return WidgetHelper.error(state.message);
                  } else {
                    return WidgetHelper.error(Constants.unknownError);
                  }
                },
              ),
              const SizedBox(height: 2),
              Text(
                "Weather for $city",
                style: AppTextTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
