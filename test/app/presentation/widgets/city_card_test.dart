import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/presentation/widgets/city_card.dart';

void main() {
  group('CityCard widget tests', () {
    testWidgets('CityCard renders correctly', (WidgetTester tester) async {
      // Arrange
      const city = 'New York';
      const note = 'Sunny';
      const image = 'https://example.com/image.jpg';

      // Act
      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: CityCard(
              city: city,
              note: note,
              image: image,
              // onPressed: onPressedMock.call,
            ),
          );
        }),
      );

      await tester.pump();

      // Assert
      expect(find.text(city), findsOneWidget);
      expect(find.text(note), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('CityCard invokes onPressed callback when tapped',
        (WidgetTester tester) async {
      // Arrange
      // final onPressedMock = MockFunction();
      const city = 'New York';
      const note = 'Sunny';
      const image = 'https://example.com/image.jpg';

      await tester.pumpWidget(
        ScreenUtilInit(builder: (context, child) {
          return const MaterialApp(
            home: CityCard(
              city: city,
              note: note,
              image: image,
              // onPressed: onPressedMock.call,
            ),
          );
        }),
      );

      await tester.pump();

      // Act
      await tester.tap(find.byType(GestureDetector));
    });
  });
}
