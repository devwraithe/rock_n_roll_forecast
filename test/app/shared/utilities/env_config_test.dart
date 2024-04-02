import 'package:flutter_test/flutter_test.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/env_config.dart';

void main() {
  test('initialize sets baseUrl and appId', () {
    // Arrange
    const baseUrl = 'mockBaseUrl';
    const appId = 'mockAppId';

    // Act
    EnvConfig.initialize(
      baseUrl: baseUrl,
      appId: appId,
    );

    // Assert
    expect(EnvConfig.baseUrl, baseUrl);
    expect(EnvConfig.appId, appId);
  });
}
