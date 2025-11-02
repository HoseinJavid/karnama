import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karnama/data/datasource/local_hive_user_setting_data_source_impl.dart';
import 'package:karnama/data/repo/user_setting_repository_impl.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/setup/service_locator.dart';

Future<void> setupSystemUiConfiguration() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
