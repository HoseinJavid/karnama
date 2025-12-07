import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/services/platform_service.dart';
import 'package:karnama/services/schedule_task_notificaton_service.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

Future<void> setTaskReminderDateTime(Task task, Jalali? reminderDate,
    TimeOfDay? reminderTime, Ringtone ringtoneSound) async {
  late DateTime result;
  if (reminderDate != null) {
    //convert to gregorian
    var baseDate = reminderDate!.toDateTime();
    if (reminderTime != null) {
      //merge (reminderTime)TimeOfDay to gregorian
      DateTime finalDateTime = DateTime(baseDate.year, baseDate.month,
          baseDate.day, reminderTime!.hour, reminderTime!.minute);
      //convert to ISO 8601
      var combinedString = finalDateTime.toIso8601String();
      task.reminderDateTime = combinedString;
      result = finalDateTime;
    } else {
      //merge Midnight to gregorian
      DateTime finalDateTime =
          DateTime(baseDate.year, baseDate.month, baseDate.day, 23, 59, 59);
      //convert to ISO 8601
      var combinedString = finalDateTime.toIso8601String();
      task.reminderDateTime = combinedString;
      result = finalDateTime;
    }

    await scheduleTaskNotification(
        scheduledTime: result,
        title: "یادآوری تسک",
        body: task.name,
        id: task.id,
        ringtoneSound: ringtoneSound.name);
  } else if (reminderTime != null) {
    //create now gregorian
    var baseDate = DateTime.now();
    //merge (reminderTime)TimeOfDay to gregorian
    DateTime finalDateTime = DateTime(baseDate.year, baseDate.month,
        baseDate.day, reminderTime!.hour, reminderTime!.minute);

    if (finalDateTime.isBefore(DateTime.now())) {
      finalDateTime = finalDateTime.add(const Duration(days: 1));
    }
    //convert to ISO 8601
    var combinedString = finalDateTime.toIso8601String();
    task.reminderDateTime = combinedString;
    result = finalDateTime;

    await scheduleTaskNotification(
        scheduledTime: result,
        title: "یادآوری تسک",
        body: task.name,
        id: task.id,
        ringtoneSound: ringtoneSound.name);
  }
}

String formatDateTime(String dateTimeISO8601, BuildContext context) {
  //parsing string ISO 8601 to DateTime model
  DateTime parsedDateTime = DateTime.parse(dateTimeISO8601);
  if (Localizations.localeOf(context).languageCode == 'fa') {
    //extract jalali
    Jalali recoveredJalali = Jalali.fromDateTime(parsedDateTime);
    //extract TimeOfDay
    TimeOfDay recoveredTime =
        TimeOfDay(hour: recoveredJalali.hour, minute: recoveredJalali.minute);

    return '${recoveredJalali.formatShortMonthDay()}  ${recoveredTime.format(context)}';
  } else {
    //extract TimeOfDay
    TimeOfDay recoveredTime =
        TimeOfDay(hour: parsedDateTime.hour, minute: parsedDateTime.minute);

    return '${parsedDateTime.toGregorian().formatter.mm} ${parsedDateTime.toGregorian().formatter.mN}  ${recoveredTime.format(context)}';
  }
}

final _player = AudioPlayer();

Future<void> playRawFile(String fileName) async {
  final Uint8List? audioBytes = await readRawFile(fileName);

  if (audioBytes != null) {
    await _player.setSourceBytes(audioBytes);
    await _player.resume();
  }
}

Future<void> stopPlayer() async {
  return await _player.stop();
}
