//Domain layer
abstract class DataSource<T> {
  //CRUD operations
  //R
  Future<T?> findById(String id);
  T? findByIndex(int index);
  Future<List<T>> getAll();
  Future<List<T>> getAllByKeyword(String keyword);
  //D
  Future<void> deleteById(String id);
  Future<void> deleteAll();
  Future<void> delete(T data);
  //C
  Future<void> add(T data);
  //U
  Future<void> update(T data);
  Future<void> updateByIndex(int index, T data);
  Future<bool> isEmpty();
}
