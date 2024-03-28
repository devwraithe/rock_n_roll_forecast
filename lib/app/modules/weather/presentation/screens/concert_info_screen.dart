import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/concert_title.dart';

import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/theme/text_theme.dart';
import '../../../../shared/utilities/constants.dart';
import '../../../../shared/utilities/helpers/responsive_helper.dart';
import '../../../../shared/utilities/helpers/widget_helper.dart';
import '../cubits/forecast/forecast_cubit.dart';
import '../cubits/forecast/forecast_state.dart';
import '../cubits/weather/weather_cubit.dart';
import '../cubits/weather/weather_state.dart';
import '../widgets/weather_forecast.dart';
import '../widgets/weather_forecast_loader.dart';
import '../widgets/weather_overview.dart';
import '../widgets/weather_overview_loader.dart';

class ConcertInfoScreen extends StatefulWidget {
  const ConcertInfoScreen({
    super.key,
    required this.arguments,
  });

  final Map<String, dynamic> arguments;

  @override
  State<ConcertInfoScreen> createState() => _ConcertInfoScreenState();
}

class _ConcertInfoScreenState extends State<ConcertInfoScreen> {
  String? location;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getWeatherData();
  }

  void getWeatherData() {
    final arguments = widget.arguments;
    final latitude = arguments['coordinates']['latitude'].toString();
    final longitude = arguments['coordinates']['longitude'].toString();

    location = arguments['location'];

    context.read<WeatherCubit>().getWeather(latitude, longitude, location!);
    context.read<ForecastCubit>().getForecast(latitude, longitude, location!);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 18 : 56),
          child: Column(
            children: [
              ConcertTitle(city: location!),
              SizedBox(height: isMobile ? 26 : 46),
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
              SizedBox(height: isMobile ? 32 : 48),
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
              const SizedBox(height: 14),
              Text(
                "Weather for $location",
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
