import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

class PrintLog {
  void printSuccess(String text) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print('\x1B[32m$text\x1B[32m');
      } else {
        log('\x1B[32m$text\x1B[32m');
      }
    }
  }

  void printPrimary(String text) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print('\x1B[34m$text\x1B[34m');
      } else {
        log('\x1B[34m$text\x1B[34m');
      }
    }
  }

  void printWarning(String text) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print('\x1B[33m$text\x1B[33m');
      } else {
        log('\x1B[33m$text\x1B[33m');
      }
    }
  }

  void printError(String text) {
    if (kDebugMode) {
      if (Platform.isAndroid) {
        print('\x1B[31m$text\x1B[0m');
      } else {
        log('\x1B[31m$text\x1B[0m');
      }
    }
  }
}
