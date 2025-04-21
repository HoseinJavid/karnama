import 'package:bloc/bloc.dart';
import 'package:karnama/model/model.dart';
import 'package:karnama/source/repository_injection.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  Repository<Task> repository;
  TaskBloc({required this.repository}) : super(TaskInitial()) {
    String querySearch;
    on<TaskEvent>((event, emit) async {
      try {
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
        } else if (event is TasksDeleteAll) {
          await repository.deleteAll();
          emit(TasksEmpty());
        } else if (event is TasksUpdate) {
          emit(TasksLoading());
          await repository.update(event.task);
          emit(TasksSuccess(await repository.getAll()));
        } else if (event is TasksCreate) {
          emit(TasksLoading());
          await repository.add(event.task);
          emit(TasksSuccess(await repository.getAll()));
        } else if (event is TasksDelete) {
          emit(TasksLoading());
          await repository.delete(event.task);
          emit(TasksSuccess(await repository.getAll()));
        }
      } catch (e) {
        emit(TasksError('unknown error'));
      }
    },);
  }
}
