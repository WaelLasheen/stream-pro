import 'package:flutter/foundation.dart';

abstract class AppDebuggingPrint {
  static void printDebug(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}
