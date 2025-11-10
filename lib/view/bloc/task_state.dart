part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

class TasksLoading extends TaskState {}

class TasksSuccess extends TaskState {
  final List<Task> tasks;
  TasksSuccess(this.tasks,);
}

class TasksEmpty extends TaskState {}

class TasksError extends TaskState {
  final String message;

  TasksError(this.message);
}
