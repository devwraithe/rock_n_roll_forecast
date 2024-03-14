import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/core/routes/routes.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/forecast/forecast_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_cubit.dart';
import 'package:rock_n_roll_forecast/app/presentation/cubits/weather/weather_state.dart';
import 'package:rock_n_roll_forecast/app/presentation/screens/concert_info_screen.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_location.dart';

import '../../core/utilities/helpers/test_helper.mocks.dart';

void main() {
  final arguments = {
    'coordinates': {
      'latitude': 0.0,
      'longitude': 0.0,
    },
    'location': 'Melbourne,Australia',
  };

  testWidgets(
    'Should show ConcertInfoScreen widget',
    (tester) async {
      final mockObserver = MockNavigatorObserver();
      final mockWeatherCubit = MockWeatherCubit();
      final mockForecastCubit = MockForecastCubit();

      when(mockWeatherCubit.state).thenReturn(WeatherLoading());
      when(mockForecastCubit.state).thenReturn(ForecastLoading());

      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<WeatherCubit>(create: (_) => mockWeatherCubit),
            BlocProvider<ForecastCubit>(create: (_) => mockForecastCubit),
          ],
          child: ScreenUtilInit(
            builder: (context, child) {
              return MaterialApp(
                navigatorObservers: [mockObserver],
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case Routes.concerts:
                      return MaterialPageRoute(
                        builder: (_) => Scaffold(
                          body: Builder(
                            builder: (context) {
                              return ConcertLocation(
                                city: "Melbourne",
                                country: "Australia",
                                note: "View",
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.concertInfo,
                                    arguments: arguments,
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    case Routes.concertInfo:
                      return MaterialPageRoute(
                        builder: (_) => ConcertInfoScreen(
                          arguments: arguments,
                        ),
                      );
                  }
                  return null;
                },
              );
            },
          ),
        ),
      );

      // await tester.pumpAndSettle();

      // expect(find.byType(ConcertInfoScreen), findsOneWidget);
      // verify(mockObserver.didPush(any, any)).called(1);
    },
  );
}
