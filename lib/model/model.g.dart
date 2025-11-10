// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      isCompleted: fields[1] as bool,
      name: fields[0] as String,
      priority: fields[2] as Priority,
      reminderDateTime: fields[4] as String?,
      id: fields[3] as int,
      desceription: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isCompleted)
      ..writeByte(2)
      ..write(obj.priority)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.reminderDateTime)
      ..writeByte(5)
      ..write(obj.desceription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserSettingAdapter extends TypeAdapter<UserSetting> {
  @override
  final int typeId = 2;

  @override
  UserSetting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSetting(
      themeIdentifer: fields[0] as String,
      latestTaskId: fields[1] as int,
      languageCode: fields[2] as String,
      selectedRingtone: fields[3] as Ringtone,
    );
  }

  @override
  void write(BinaryWriter writer, UserSetting obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.themeIdentifer)
      ..writeByte(1)
      ..write(obj.latestTaskId)
      ..writeByte(2)
      ..write(obj.languageCode)
      ..writeByte(3)
      ..write(obj.selectedRingtone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PriorityAdapter extends TypeAdapter<Priority> {
  @override
  final int typeId = 1;

  @override
  Priority read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Priority.low;
      case 1:
        return Priority.normal;
      case 2:
        return Priority.high;
      default:
        return Priority.low;
    }
  }

  @override
  void write(BinaryWriter writer, Priority obj) {
    switch (obj) {
      case Priority.low:
        writer.writeByte(0);
        break;
      case Priority.normal:
        writer.writeByte(1);
        break;
      case Priority.high:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriorityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RingtoneAdapter extends TypeAdapter<Ringtone> {
  @override
  final int typeId = 3;

  @override
  Ringtone read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Ringtone.defaultalarm;
      case 1:
        return Ringtone.bellalarm;
      case 2:
        return Ringtone.chimealarm;
      case 3:
        return Ringtone.galaxyalarm;
      case 4:
        return Ringtone.funnyalarm;
      default:
        return Ringtone.defaultalarm;
    }
  }

  @override
  void write(BinaryWriter writer, Ringtone obj) {
    switch (obj) {
      case Ringtone.defaultalarm:
        writer.writeByte(0);
        break;
      case Ringtone.bellalarm:
        writer.writeByte(1);
        break;
      case Ringtone.chimealarm:
        writer.writeByte(2);
        break;
      case Ringtone.galaxyalarm:
        writer.writeByte(3);
        break;
      case Ringtone.funnyalarm:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RingtoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
