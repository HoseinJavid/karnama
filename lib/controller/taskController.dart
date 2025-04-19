import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mdata_base/model/model.dart';

class TaskController {
  late Box<Task> _taskBox;

  Future<void> initHiveDb(String dbName) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(PriorityAdapter());
    _taskBox = await Hive.openBox<Task>(dbName);
    // await Future.wait([
    //   _taskBox.add(Task(
    //       name: ' Wake up early (e.g., 6:30 AM)', priority: Priority.high)),
    //   _taskBox
    //       .add(Task(name: ' Drink a glass of water', priority: Priority.low)),
    //   _taskBox.add(Task(
    //       name: 'Exercise or stretch (15–30 minutes)',
    //       priority: Priority.high)),
    //   _taskBox.add(Task(
    //       name: ' Check and respond to important emails/messages',
    //       priority: Priority.low,
    //       isCompleted: true)),
    //   _taskBox.add(Task(
    //       name:
    //           'Take a 10-minute break after every 50–60 minutes of focused work',
    //       priority: Priority.normal)),
    //   _taskBox.add(Task(
    //       name: ' Read [specific book/article] (e.g., 10–20 pages)',
    //       priority: Priority.normal,
    //       isCompleted: true))
    // ]);
  }

//read and update with index
  Future<void> toggleTask(int index, Task task) async {
    Task? taskOld = _taskBox.getAt(index);
    if (taskOld != null) {
      _taskBox.putAt(index, task);
    }
  }

//delete
  Future<void> deleteTaskByIndex(int index) async {
    if (_taskBox.getAt(index) != null) {
      _taskBox.deleteAt(index);
    }
  }

//delete
  Future<void> deleteAllTask() async {
    await _taskBox.clear();
  }

//read and update with id or key
  Future<void> toggleTaskById(String id, Task task) async {
    Task? taskOld = _taskBox.get(id);
    if (taskOld != null) {
      _taskBox.put(id, task);
    }
  }

//read and delete
  Future<void> deleteTaskById(String id) async {
    if (_taskBox.get(id) != null) {
      _taskBox.delete(id);
    }
  }

//update
  Future<void> addTask(Task task) async {
    _taskBox.add(task);
  }

//read
  Task? getTaskByIndex(int index) {
    return _taskBox.getAt(index);
  }

  bool isNotEmpty() {
    return _taskBox.isNotEmpty;
  }

  bool isEmpty() {
    return _taskBox.isEmpty;
  }

  getListanable() {
    return _taskBox.listenable();
  }

  Iterable<Task> getValues() {
    return _taskBox.values;
  }
}
