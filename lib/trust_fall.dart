import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class TrustFall {
  static const MethodChannel _channel =
      const MethodChannel('trust_fall');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  //Checks whether device JailBroken on iOS/Android?
  static Future<bool> get isJailBroken async {
    final bool isJailBroken = await _channel.invokeMethod('isJailBroken');
    return isJailBroken;
  }

  //Can this device mock location - no need to root!
  static Future<bool> get canMockLocation async {
    final bool canMockLocation = await _channel.invokeMethod('canMockLocation');
    return canMockLocation;
  }

  // Checks whether device is real or emulator
  static Future<bool> get isRealDevice async {
    final bool isRealDevice = await _channel.invokeMethod('isRealDevice');
    return isRealDevice;
  }

  // (ANDROID ONLY) Check if application is running on external storage
  static Future<bool> get isOnExternalStorage async {
    final bool isOnExternalStorage = await _channel.invokeMethod('isOnExternalStorage');
    return isOnExternalStorage;
  }

  // Check if device violates any of the above
  static Future<bool> get isTrustFall async {
    final bool isJailBroken = await _channel.invokeMethod('isJailBroken');
    final bool canMockLocation = await _channel.invokeMethod('canMockLocation');
    final bool isRealDevice = await _channel.invokeMethod('isRealDevice');
    if(Platform.isAndroid){
      final bool isOnExternalStorage = await _channel.invokeMethod('isOnExternalStorage');
      return isJailBroken || canMockLocation || !isRealDevice || isOnExternalStorage;
    }else{
      return isJailBroken || canMockLocation || !isRealDevice;
    }
  }
}
