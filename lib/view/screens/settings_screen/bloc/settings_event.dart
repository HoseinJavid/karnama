part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {}

class ChangeRingtoneNotificatonSettingEvent extends SettingsEvent {
  final Ringtone ringtone;

  ChangeRingtoneNotificatonSettingEvent({required this.ringtone});
  
}