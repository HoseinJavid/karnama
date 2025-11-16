import 'package:flutter/services.dart';

   const platform = MethodChannel('com.hoseinjavid.karnama/battery_settings');

  Future<void> openBatteryOptimizationSettings() async {
    try {
      await platform.invokeMethod('openBatterySettings');
    } on PlatformException catch (e) {
      print("Failed to open battery settings: '${e.message}'.");
    }
  }

Future<bool> isBatteryOptimizationIgnored() async {
    try {
      final bool? isIgnored = await platform.invokeMethod('isOptimizationIgnored');
      return isIgnored ?? false; 
    } on PlatformException catch (e) {
      print("Failed to check battery optimization status: '${e.message}'.");
      return false; 
    }
  }