import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' hide Priority;
import 'package:karnama/data/repo/user_setting_repository_impl.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/data/repo/tesk_repository_impl.dart';
import 'package:karnama/setup/service_locator.dart';
import 'package:karnama/util.dart';
import 'package:meta/meta.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../model/model.dart' hide Priority;

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  Repository<Task> repository;
  UserSettingRepository userSettingRepository;
  TaskBloc({required this.repository, required this.userSettingRepository})
      : super(TaskInitial()) {
    String querySearch;
    on<TaskEvent>(
      (event, emit) async {
        try {
          //init start -----------------------------------------------------------------
          if (event is TasksStarted || event is TasksSearch) {
            emit(TasksLoading());
            if (event is TasksSearch) {
              querySearch = event.query;
            } else {
              querySearch = '';
            }
            final tasks = await repository.getAllByKeyword(querySearch);
            if (tasks.isEmpty) {
              emit(TasksEmpty());
            } else {
              emit(TasksSuccess(tasks));
            }
            //delete all -----------------------------------------------------------------
          } else if (event is TasksDeleteAll) {
            flutterLocalNotificationsPlugin.cancelAll();
            flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()!
                .stopForegroundService();
            await repository.deleteAll();
            emit(TasksEmpty());
            //update -----------------------------------------------------------------
          } else if (event is TasksUpdate) {
            emit(TasksLoading());
            event.oldTask.name = event.taskName;
            event.oldTask.priority = event.prioritySelected;
            event.oldTask.isCompleted = event.isCompleted;
            event.oldTask.desceription = event.taskDesceription;
            if (event.isCompleted == true) {
              //delete notif
              var listPendingNotif = await flutterLocalNotificationsPlugin
                  .pendingNotificationRequests();
              for (var pendingNotification in listPendingNotif) {
                if (pendingNotification.id == event.oldTask.id) {
                  await flutterLocalNotificationsPlugin
                      .cancel(pendingNotification.id);
                }
              }
            }
            var usersetting = await userSettingRepository.getUserSetting();
            await setTaskReminderDateTime(event.oldTask, event.reminderDate,
                event.reminderTime, usersetting!.selectedRingtone);
            await repository.update(event.oldTask);
            var t = await repository.getAll();
            emit(TasksSuccess(t));
            //create -----------------------------------------------------------------
          } else if (event is TasksCreate) {
            emit(TasksLoading());
            // update user setting
            var usersetting = await userSettingRepository.getUserSetting();
            usersetting!.latestTaskId++;
            Task task = Task(
                name: event.taskName,
                priority: event.prioritySelected,
                id: usersetting.latestTaskId,
                desceription: event.taskDesceription);
            await userSettingRepository.updateAllUserSetting(usersetting);
            await setTaskReminderDateTime(task, event.reminderDate,
                event.reminderTime, usersetting.selectedRingtone);
            await repository.add(task);
            var t = await repository.getAll();
            emit(TasksSuccess(t));
            //delete -----------------------------------------------------------------
          } else if (event is TasksDelete) {
            emit(TasksLoading());
            await flutterLocalNotificationsPlugin.cancel(event.task.id);
            await repository.delete(event.task);
            var t = await repository.getAll();
            if (t.isEmpty) {
              flutterLocalNotificationsPlugin
                  .resolvePlatformSpecificImplementation<
                      AndroidFlutterLocalNotificationsPlugin>()!
                  .stopForegroundService();
              emit(TasksEmpty());
            } else {
              emit(TasksSuccess(t));
            }
          }
        } catch (e) {
          emit(TasksError('خطای نامشخص دوباره تلاش کن'));
        }
      },
    );
  }
}
