import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/app.dart';
import 'package:rock_n_roll_forecast/app/modules/weather/presentation/screens/concerts_screen.dart';
import 'package:rock_n_roll_forecast/app/shared/services/di_service.dart' as di;

void main() {
  testWidgets('Should build RockBand widget', (WidgetTester tester) async {
    di.init();

    // pump the widget tree
    await tester.pumpWidget(
      const RockBand(),
    );

    await tester.pumpAndSettle();

    // Verify
    expect(find.byType(MultiBlocProvider), findsOneWidget);
    expect(find.byType(ScreenUtilInit), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(ConcertsScreen), findsOneWidget);
  });
}
