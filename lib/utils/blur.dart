import 'package:flutter/services.dart';

class BlurHandler {
  static const MethodChannel _channel = MethodChannel('blur_handler');

  static Future<void> enableBlur() async {
    try {
      await _channel.invokeMethod('enableBlur');
    } on PlatformException catch (e) {
      print("Failed to enable blur: '${e.message}'.");
    }
  }

  static Future<void> disableBlur() async {
    try {
      await _channel.invokeMethod('disableBlur');
    } on PlatformException catch (e) {
      print("Failed to disable blur: '${e.message}'.");
    }
  }
}