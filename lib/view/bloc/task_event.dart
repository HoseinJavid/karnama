part of 'task_bloc.dart';

@immutable
sealed class TaskEvent {}

class TasksStarted extends TaskEvent {}

class TasksSearch extends TaskEvent {
  final String query;

  TasksSearch(this.query);
}

class TasksDeleteAll extends TaskEvent {}

class TasksUpdate extends TaskEvent {
  final Task oldTask;
  final Jalali? reminderDate;
  final TimeOfDay? reminderTime;
  final String taskName;
  final Priority prioritySelected;
  final bool isCompleted;
  final String taskDesceription;

  TasksUpdate(
      {required this.oldTask,
      required this.reminderDate,
      required this.reminderTime,
      required this.prioritySelected,
      required this.taskName,
      this.isCompleted = false,
      required this.taskDesceription});
}

class TasksCreate extends TaskEvent {
  final Jalali? reminderDate;
  final TimeOfDay? reminderTime;
  final String taskName;
  final Priority prioritySelected;
  final String taskDesceription;

  TasksCreate(
      {required this.reminderDate,
      required this.reminderTime,
      required this.prioritySelected,
      required this.taskName,
      required this.taskDesceription});
}

class TasksDelete extends TaskEvent {
  final Task task;

  TasksDelete(this.task);
}
