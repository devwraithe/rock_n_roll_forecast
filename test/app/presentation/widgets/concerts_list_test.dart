import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/domain/entities/location_entity.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concert_location.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/concerts_list.dart';

void main() {
  const locationEntity = LocationEntity(
    city: "Melbourne",
    country: "Australia",
  );

  testWidgets(
    'Should build the ConcertsList widget',
    (WidgetTester tester) async {
      final List<LocationEntity> locations = [
        locationEntity,
      ];

      final loadingStates = {
        locations[0].city: ValueNotifier<bool>(false),
      };

      await tester.pumpWidget(
        ScreenUtilInit(
          builder: (context, child) {
            return MaterialApp(
              home: Scaffold(
                body: Column(
                  children: [
                    ConcertsList(
                      locations: locations,
                      loadingStates: loadingStates,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      await tester.pump();

      expect(find.byType(Expanded), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ConcertLocation), findsNWidgets(locations.length));
    },
  );
}
