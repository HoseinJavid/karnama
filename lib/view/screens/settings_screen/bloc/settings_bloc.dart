import 'package:bloc/bloc.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/data/repo/user_setting_repository_impl.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/services/schedule_task_notificaton_service.dart';
import 'package:karnama/setup/service_locator.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UserSettingRepository userSettingRepository;
  final Repository<Task> repository;
  SettingsBloc(this.userSettingRepository, this.repository)
      : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) async {
      if (event is ChangeRingtoneNotificatonSettingEvent) {
        //get custom sound notif

        //update cache custom setting
        var usersetting = await userSettingRepository.getUserSetting();
        usersetting!.selectedRingtone = event.ringtone;
        userSettingRepository.updateAllUserSetting(usersetting);
        //delete all notif
        await flutterLocalNotificationsPlugin.cancelAll();
        await flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
        //get all tasks
        var allTasks = await repository.getAll();
        //set all notif task with custom sound
        for (var task in allTasks) {
          if (task.reminderDateTime != null) {
            var dateTime = DateTime.parse(task.reminderDateTime!);
            //Check that the date has not expired
            if (dateTime.isAfter(DateTime.now())) {
              await scheduleTaskNotification(
                  scheduledTime: dateTime,
                  title: "یادآوری تسک",
                  body: task.name,
                  id: task.id,
                  ringtoneSound: event.ringtone.name);
            }
          }
        }
      }
    });
  }
}
