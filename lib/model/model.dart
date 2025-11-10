import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(
      {this.isCompleted = false,
      this.name = '',
      this.priority = Priority.low,
      this.reminderDateTime,
      required this.id});
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  Priority priority = Priority.low;
  @HiveField(3)
  int id;
  @HiveField(4)
  String? reminderDateTime;

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'isCompleted': isCompleted,
      'priority': priority.index,
      'id': id,
      'reminderDateTime': reminderDateTime
    };
  }

  static Task fromMap(Map<String, Object?> first) {
    return Task(
        name: first['name'] as String,
        isCompleted: first['isCompleted'] as bool,
        priority: Priority.values[first['priority'] as int],
        reminderDateTime: first['reminderDateTime'] as String,
        id: first['id'] as int);
  }
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  high
}

//user setting model -----------------------------------------------------
@HiveType(typeId: 2)
class UserSetting {
  @HiveField(0)
  String themeIdentifer;
  @HiveField(1)
  int latestTaskId;
  @HiveField(2)
  String languageCode;
  @HiveField(3)
  Ringtone selectedRingtone;

  UserSetting(
      {required this.themeIdentifer,
      this.latestTaskId = 0,
      required this.languageCode,
      required this.selectedRingtone});
}

@HiveType(typeId: 3)
enum Ringtone {
  @HiveField(0)
  defaultalarm,
  @HiveField(1)
  bellalarm,
  @HiveField(2)
  chimealarm,
  @HiveField(3)
  galaxyalarm,
  @HiveField(4)
  funnyalarm
}
