import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class MiscHelper {
  static Future<bool> hasInternetConnection() async {
    final Connectivity connectivity = Connectivity();
    final ConnectivityResult connectivityResult =
        await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
