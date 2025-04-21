import 'package:flutter/foundation.dart';
import 'package:todolist/model/model.dart';
import 'package:todolist/source/source_abs.dart';

class Repository<T> extends ChangeNotifier implements DataSource<T> {
  final DataSource<T> injectDataSourceImpl;

  Repository({required this.injectDataSourceImpl});
  @override
  Future<void> delete(T data) {
    // notifyListeners();
    return injectDataSourceImpl.delete(data).then(
          (value) => notifyListeners(),
        );
  }

  @override
  Future<void> deleteAll() async {
    return injectDataSourceImpl.deleteAll().then(
          (value) => notifyListeners(),
        );
  }

  @override
  Future<void> deleteById(String keyword) {
    notifyListeners();
    return injectDataSourceImpl.deleteById(keyword);
  }

  @override
  Future<T?> findById(String keyword) {
    // notifyListeners();
    return injectDataSourceImpl.findById(keyword);
  }

  @override
  Future<List<T>> getAll() async {
    // notifyListeners();
    return await injectDataSourceImpl.getAll();
  }

  @override
  Future<void> add(T data) {
    return injectDataSourceImpl.add(data).then(
          (value) => notifyListeners(),
        );
  }

  @override
  Future<void> update(T data) {
    notifyListeners();
    return injectDataSourceImpl.update(data);
  }

  Future<bool> isNotEmpty()async {
    // notifyListeners();
    return ! await injectDataSourceImpl.isEmpty();
  }

  @override
  Future<bool> isEmpty() {
    // notifyListeners();
    return injectDataSourceImpl.isEmpty();
  }

  @override
  T? findByIndex(int index) {
    // notifyListeners();
    return injectDataSourceImpl.findByIndex(index);
  }

  toggleTask(int i, Task task) {
    // notifyListeners();
  }

  void deleteByIndex(int index) {
    notifyListeners();
    injectDataSourceImpl.delete(injectDataSourceImpl.findByIndex(index)!);
  }

  getListanable() {}

  @override
  Future<void> updateByIndex(int index, T data) {
    // TODO: implement updateByIndex
    throw UnimplementedError();
  }

  @override
  Future<List<T>> getAllByKeyword(String keyword) async {
    var temp = await injectDataSourceImpl.getAllByKeyword(keyword);
    notifyListeners();
    return temp;
  }
}
