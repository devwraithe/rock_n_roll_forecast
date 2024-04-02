import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/domain/entities/location_entity.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/concert_location.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/widgets/concerts_list.dart';

void main() {
  const location = LocationEntity(
    city: "Melbourne",
    country: "Australia",
  );

  testWidgets(
    'Should build the ConcertsList widget',
    (WidgetTester tester) async {
      final List<LocationEntity> locations = [
        location,
      ];

      await tester.pumpWidget(
        ScreenUtilInit(
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    ConcertsList(locations: locations),
                  ],
                ),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(Expanded), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ConcertLocation), findsNWidgets(locations.length));
    },
  );

  // test(
  //   'getCoordinates should call cityCoordinates when there is internet connection',
  //   () async {
  //     final coordinates = {'latitude': 37.7749, 'longitude': -122.4194};
  //
  //     when(MiscHelper.hasInternetConnection()).thenAnswer((_) async => true);
  //     when(
  //       LocationHelper.cityCoordinates(
  //         location.city,
  //       ),
  //     ).thenAnswer(
  //       (_) async => coordinates,
  //     );
  //
  //     await widget.getCoordinates(location);
  //
  //     verify(
  //       mockWidget.loadingStates[location.city]?.value = true,
  //     ).called(1);
  //     verify(
  //       LocationHelper.cityCoordinates(
  //         "${location.city}, ${location.country}",
  //       ),
  //     ).called(1);
  //     verify(
  //       mockWidget._goToConcertInfo(
  //         coordinates,
  //         location,
  //       ),
  //     ).called(1);
  //     verify(
  //       mockWidget.loadingStates[location.city]?.value = false,
  //     ).called(1);
  //   },
  // );
}
