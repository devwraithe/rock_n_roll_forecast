import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/forecast_entity.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/weather_entity.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concert_info_screen.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_title.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_forecast.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_forecast_loader.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_overview.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/weather_overview_loader.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  final arguments = {
    'coordinates': {
      'latitude': 0.0,
      'longitude': 0.0,
    },
    'location': 'Melbourne, Australia',
  };

  const weatherEntity = WeatherEntity(
    lon: 100.0,
    lat: 50.0,
    main: 'Cloudy',
    description: 'Partly Cloudy',
    iconCode: '03d',
    temperature: 25,
    wind: 2,
    humidity: 70,
    feelsLike: 25,
  );

  const forecastEntity = ForecastEntity(
    dailyTime: 1625695200,
    dailyMinTemp: 25.0,
    dailyMaxTemp: 30.0,
    dailyIcon: '01d',
  );

  final mockWeatherCubit = MockWeatherCubit();
  final mockForecastCubit = MockForecastCubit();

  when(mockWeatherCubit.state).thenReturn(WeatherLoading());
  when(mockForecastCubit.state).thenReturn(ForecastLoading());

  testWidgets(
    'Should show loading UI when weather is loading',
    (tester) async {
      when(mockWeatherCubit.stream).thenAnswer(
        (_) => Stream<WeatherState>.fromIterable(
          [WeatherLoading()],
        ),
      );
      when(mockForecastCubit.stream).thenAnswer(
        (_) => Stream<ForecastLoading>.fromIterable(
          [ForecastLoading()],
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>(create: (_) => mockWeatherCubit),
            BlocProvider<ForecastCubit>(create: (_) => mockForecastCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                home: ConcertInfoScreen(
                  arguments: arguments,
                ),
              );
            },
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(ConcertInfoScreen), findsOneWidget);
      expect(find.byType(WeatherOverviewLoader), findsOneWidget);
      expect(find.byType(WeatherForecastLoader), findsOneWidget);
    },
  );

  testWidgets(
    'Should show error UI when weather fetch fails',
    (tester) async {
      when(mockWeatherCubit.stream).thenAnswer(
        (_) => Stream<WeatherState>.fromIterable(
          [const WeatherError("Failed to fetch weather")],
        ),
      );
      when(mockForecastCubit.stream).thenAnswer(
        (_) => Stream<ForecastState>.fromIterable(
          [const ForecastError("Failed to fetch forecasts")],
        ),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>(create: (_) => mockWeatherCubit),
            BlocProvider<ForecastCubit>(create: (_) => mockForecastCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                home: ConcertInfoScreen(
                  arguments: arguments,
                ),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Failed to fetch weather'), findsOneWidget);
      expect(find.text('Weather for Melbourne, Australia'), findsOneWidget);
    },
  );

  testWidgets(
    'Should show weather overview and forecast when loaded',
    (tester) async {
      when(mockWeatherCubit.stream).thenAnswer(
        (_) => Stream<WeatherState>.fromIterable(
          [const WeatherLoaded(weatherEntity)],
        ),
      );
      when(mockForecastCubit.stream).thenAnswer(
        (_) => Stream<ForecastState>.fromIterable([
          const ForecastLoaded([forecastEntity])
        ]),
      );

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>(create: (_) => mockWeatherCubit),
            BlocProvider<ForecastCubit>(create: (_) => mockForecastCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                home: ConcertInfoScreen(
                  arguments: arguments,
                ),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ConcertTitle), findsOneWidget);
      expect(find.text('Melbourne, Australia'), findsOneWidget);
      expect(find.byType(WeatherOverview), findsOneWidget);
      expect(find.byType(WeatherForecast), findsOneWidget);
    },
  );
}
