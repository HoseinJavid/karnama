import 'package:flutter/services.dart';

   const platformRawReader = MethodChannel('com.hoseinjavid.karnama/raw_reader');
   const platformBatterySettings = MethodChannel('com.hoseinjavid.karnama/battery_settings');

  Future<void> openBatteryOptimizationSettings() async {
    try {
      await platformBatterySettings.invokeMethod('openBatterySettings');
    } on PlatformException catch (e) {
      print("Failed to open battery settings: '${e.message}'.");
    }
  }

Future<bool> isBatteryOptimizationIgnored() async {
    try {
      final bool? isIgnored = await platformBatterySettings.invokeMethod('isOptimizationIgnored');
      return isIgnored ?? false; 
    } on PlatformException catch (e) {
      print("Failed to check battery optimization status: '${e.message}'.");
      return false; 
    }
  }

  Future<Uint8List?> readRawFile(String fileName) async {
  try {
    final Uint8List? result = await platformRawReader.invokeMethod(
      'readRawFile', 
      {'fileName': fileName}
    );
    return result;
  } on PlatformException catch (e) {
    print("Failed to read raw file: ${e.message}");
    return null;
  }
}


