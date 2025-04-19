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
  @HiveField(3)
  int _id = -1;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, Object?> toMap() { 
    return {
      'name': name,
      'isCompleted': isCompleted,
      'priority': priority.index,
      'id': id
    };
  }

  static Task fromMap(Map<String, Object?> first) {
    return Task(
      name: first['name'] as String,
      isCompleted: first['isCompleted'] as bool,
      priority: Priority.values[first['priority'] as int],
    );
  }
   
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
