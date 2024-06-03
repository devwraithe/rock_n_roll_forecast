import 'package:flutter/foundation.dart';

void securePrint(String message) {
  if (!kReleaseMode) {
    debugPrint('[DEBUG] $message');
  }
}
