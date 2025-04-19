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
  final Task task;

  TasksUpdate(this.task);
}

class TasksCreate extends TaskEvent {
  final Task task;

  TasksCreate(this.task);
}

class TasksDelete extends TaskEvent {
  final Task task;

  TasksDelete(this.task);
}
