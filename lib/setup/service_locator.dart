import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:karnama/model/model.dart';

late Box<Task> taskbox;
late Box<UserSetting> UserSettingBox;
Future<void> setupServiceLocator() async {
  
  //init hive db ---------------------------------
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  Hive.registerAdapter(UserSettingAdapter());
  taskbox = await Hive.openBox<Task>(
    'task',
  );
  UserSettingBox = await Hive.openBox('usersetting');
}
