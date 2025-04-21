import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/model/model.dart';

class Util {
  static Future<Box<T>> initHiveDb<T>(String boxName) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    Hive.registerAdapter(PriorityAdapter());
    return await Hive.openBox<T>(boxName);
  }
}
