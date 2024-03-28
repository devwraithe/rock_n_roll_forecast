import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/app.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/di_service.dart'
    as di;

void main() {
  testWidgets('Should initialize the app', (tester) async {
    // Ensure the test environment is initialized
    TestWidgetsFlutterBinding.ensureInitialized();

    // Initialize the dependency injector
    di.init();

    // Ensure the screen size is available for responsive UI testing
    await ScreenUtil.ensureScreenSize();

    // Pump the widget tree
    await tester.pumpWidget(
      const RockAndRoll(),
    );
  });
}
