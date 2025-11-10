// // import 'package:flutter/widgets.dart';
// // import 'package:flutter_test/flutter_test.dart';
// // import 'package:hive/hive.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'dart:io';

// // void main() {
// //   late Box<String> testBox;

// //   // 1. مقداردهی اولیه Hive و باز کردن Box قبل از هر تست
// //   setUp(() async {
// //     Hive.init("test/db"); // مقداردهی اولیه Hive با دایرکتوری موقت
// //     testBox = await Hive.openBox<String>('testBox');
// //   });

// //   // 2. پاکسازی داده‌ها و بستن Box بعد از هر تست
// //   tearDown(() async {
// //     await testBox.clear(); // پاکسازی داده‌ها
// //     await testBox.close(); // بستن Box
// //   });

// //   // 3. نوشتن و خواندن داده‌ها در تست‌ها
// //   test('should save and retrieve data from Hive box', () async {
// //     // ذخیره داده در Box
// //     await testBox.put('username', 'john_doe');

// //     // بازیابی داده از Box
// //     final result = testBox.get('username');

// //     // بررسی اینکه داده به درستی ذخیره شده است
// //     expect(result, 'john_doe');
// //   });

// //   test('should return null if key does not exist', () async {
// //     // بازیابی داده از Box برای کلید غیرموجود
// //     final result = testBox.get('non_existent_key');

// //     // بررسی اینکه نتیجه null باشد
// //     expect(result, null);
// //   });
// // }

// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive/hive.dart';
// import 'package:karnama/data/repo/tesk_repository_impl.dart';
// import 'package:karnama/model/model.dart';
// import 'package:karnama/data/datasource/local_hive_task_data_source_impl.dart';

// void main() {
//   late Box<Task> box;
//   late HiveTaskImpl hiveTaskImpl;
//   late Repository<Task> repository;

//   setUpAll(() async {
//     Hive.registerAdapter(TaskAdapter());
//     Hive.registerAdapter(PriorityAdapter());
//     Hive.init('test/db');
//     box = await Hive.openBox<Task>('tasktestbox');
//     hiveTaskImpl = HiveTaskImpl(box: box);
//     repository = Repository<Task>(injectDataSourceImpl: hiveTaskImpl);
//   });

//   tearDownAll(() async {
//     await box.close();
//   });
//   tearDown(
//     () async {
//       await box.clear();
//     },
//   );

//   group('Repository with HiveTaskImpl tests', () {
//     test('should save task to Hive', () async {
//       final task = Task(name: 'Test Task');
//       //save and set key
//       await repository.add(task);
//       final savedTask = await repository.findById(task.key.toString());
//       expect(savedTask, isNotNull);
//       expect(savedTask?.key, task.key);
//       expect(savedTask?.name, 'Test Task');
//     });

//     test('should get all tasks from Hive', () async {
//       final task1 = Task(name: 'Test Task 1');
//       final task2 = Task(name: 'Test Task 2');

//       await repository.add(task1);
//       await repository.add(task2);

//       final tasks = await repository.getAll();
//       expect(tasks.length, 2);
//       expect(tasks[0].name, 'Test Task 1');
//       expect(tasks[1].name, 'Test Task 2');
//     });

//     test('should update task in Hive', () async {
//       final task = Task(name: 'Test Task');
//       await repository.add(task);

//       task.name = 'Updated Task';
//       await repository.update(task);

//       final updatedTask = await repository.findById(task.key.toString());
//       expect(updatedTask?.name, 'Updated Task');
//     });

//     test('should delete task from Hive', () async {
//       final task = Task(name: 'Test Task');
//       await repository.add(task);

//       await repository.delete(task);

//       final deletedTask = await repository.findById(task.toString());
//       expect(deletedTask, isNull);
//     });

//     test('should delete all tasks from Hive', () async {
//       final task1 = Task(name: 'Test Task 1');
//       final task2 = Task(name: 'Test Task 2');
//       await repository.add(task1);
//       await repository.add(task2);

//       await repository.deleteAll();

//       final allTasks = await repository.getAll();
//       expect(allTasks.isEmpty, true);
//     });
//   });
// }
