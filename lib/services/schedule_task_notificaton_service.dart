import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:karnama/setup/service_locator.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

Future<void> scheduleTaskNotification(
    {required DateTime scheduledTime,
    required String title,
    required String body,
    required int id,
    required String ringtoneSound}) async {
  //request permission -----------------------------------------------
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();
  //inital time zone -----------------------------------------------
  tz.initializeTimeZones();
  var timez = await FlutterTimezone.getLocalTimezone();
  final String timeZoneName = timez.identifier;
  tz.setLocalLocation(tz.getLocation(timeZoneName));

  final tz.TZDateTime tzScheduledTime =
      tz.TZDateTime.from(scheduledTime, tz.local);

  //detail notif
  NotificationDetails notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails('task_channel_id_$ringtoneSound', 'Task Reminders ($ringtoneSound)',
        channelDescription: 'Notifications for task reminders',
        importance: Importance.max,
        priority: Priority.high,
        sound: RawResourceAndroidNotificationSound(ringtoneSound)),
    iOS: const DarwinNotificationDetails(),
  );

//schedule notif
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tzScheduledTime,
    notificationDetails,
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );
  print('Notification scheduled for $tzScheduledTime');
}
