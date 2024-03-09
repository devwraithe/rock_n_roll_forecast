import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/app.dart';
import 'package:rock_n_roll_forecast/app/core/utilities/di_service.dart' as di;

void main() {
  testWidgets('should initialize the app', (tester) async {
    // ensure the test environment is initialized
    TestWidgetsFlutterBinding.ensureInitialized();

    // initialize the dependency injector
    di.init();

    // ensure the screen size is available for responsive UI testing
    await ScreenUtil.ensureScreenSize();

    // pump the widget tree
    await tester.pumpWidget(
      const RockAndRoll(),
    );
  });
}
