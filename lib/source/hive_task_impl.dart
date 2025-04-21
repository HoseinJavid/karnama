import 'package:hive/hive.dart';
import 'package:todolist/model/model.dart';
import 'package:todolist/source/source_abs.dart';

//Data layer
class HiveTaskImpl implements DataSource<Task> {
  final Box<Task> box;

  HiveTaskImpl({required this.box});
  @override
  Future<void> delete(Task data) async {
    return await data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(String keyword) async {
    final key = box.keys.firstWhere(
      (key) => key.toString() == keyword,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  @override
  Future<Task?> findById(String keyword) async {
    final key = box.keys.firstWhere(
      (key) => key.toString() == keyword,
      orElse: () => null,
    );
    if (key != null) {
      return box.get(key);
    }
    return null;
  }

  @override
  Future<List<Task>> getAll() async {
    return box.values.toList();
  }

  @override
  Future<void> add(Task data) async {
    //sync key and id
    data.id = await box.add(data);
  }

  @override
  Future<void> update(Task data) async {
    await data.save();
  }

  @override
  Future<bool> isEmpty() {
    return Future.value(box.isEmpty);
  }

  @override
  Task? findByIndex(int index) {
    return box.getAt(index);
  }

  @override
  Future<void> updateByIndex(int index, Task data) {
    // TODO: implement updateByIndex
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllByKeyword(String keyword) async {
    return box.values.where((task) => task.name.contains(keyword)).toList();
  }

  // Future<Task> createOrUpdeate(Task task) async {
  //   if (task.isInBox) {
  //     task.save();
  //   } else {
  //     box.add(task);
  //   }
  //   return task;
  // }
}
