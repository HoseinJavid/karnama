import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:karnama/model/model.dart';

late Box<Task> taskbox;
late Box<UserSetting> UserSettingBox;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
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

  //init local notification ---------------------
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //request permision ---------------------------------------
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.requestNotificationsPermission();

  //android init
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  //ios init
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );
}
