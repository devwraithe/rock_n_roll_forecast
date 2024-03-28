import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rock_n_roll_forecast/app/shared/utilities/adapters/connectivity_adapter/connectivity_plus_adapter.dart';

import '../helpers/test_helper.mocks.dart'; // Adjust the import based on your project structure

void main() {
  test('Returns true when connected to a mobile network', () async {
    // Create a mock instance of Connectivity
    final mockConnectivity = MockConnectivity();

    // Define behavior for checkConnectivity (simulating mobile network)
    when(mockConnectivity.checkConnectivity()).thenAnswer(
      (_) async => ConnectivityResult.mobile,
    ); // Stub for checkConnectivity

    // Initialize the adapter with the mock instance
    final adapter = ConnectivityPlusAdapter(mockConnectivity);

    // Call the isConnected method to check network connectivity
    final isConnected = await adapter.isConnected();

    // Expectation for connected state
    expect(isConnected, true);
  });

  test('Returns true when connected to a mobile network', () async {
    // Create a mock instance of Connectivity
    final mockConnectivity = MockConnectivity();

    // Define behavior for checkConnectivity (simulating mobile network)
    when(mockConnectivity.checkConnectivity()).thenAnswer(
      (_) async => ConnectivityResult.none,
    ); // Stub for checkConnectivity

    // Initialize the adapter with the mock instance
    final adapter = ConnectivityPlusAdapter(mockConnectivity);

    // Call the isConnected method to check network connectivity
    final isConnected = await adapter.isConnected();

    // Expectation for connected state
    expect(isConnected, false);
  });
}
