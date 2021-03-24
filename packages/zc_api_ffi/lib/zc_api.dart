
import 'dart:async';

import 'package:flutter/services.dart';

class ZcApi {
  static const MethodChannel _channel =
      const MethodChannel('zc_api');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
