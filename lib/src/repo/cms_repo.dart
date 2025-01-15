import 'package:impaktfull_cms/impaktfull_cms.dart';

///
abstract class CmsRepository<T, E> {
  Future<T> save(T item);

  Future<T> update(E id, T item);

  Future<void> delete(T item);

  Future<T> load(E id);

  Future<PagingInfo<T>> loadAll({
    required int page,
    required int pageSize,
    String? searchQuery,
  });
}
