import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task(
      {this.isCompleted = false, this.name = '', this.priority = Priority.low});
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  Priority priority = Priority.low;
}

@HiveType(typeId: 1)
enum Priority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  high
}
