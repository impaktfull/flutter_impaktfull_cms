import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/data/user.dart';
import 'package:impaktfull_cms_example/repo/user_repo.dart';

class CmsUserRepo extends CmsRepository<User, int> {
  @override
  Future<PagingInfo<User>> loadAll({
    required int page,
    required int pageSize,
    String? searchQuery,
  }) async =>
      UserRepo.instance.getUsers(
        page: page,
        pageSize: pageSize,
        searchQuery: searchQuery,
      );

  @override
  Future<User> load(int id) async => UserRepo.instance.getUser(id);

  @override
  Future<void> delete(User item) async => UserRepo.instance.delete(item);

  @override
  Future<User> save(User item) async => UserRepo.instance.save(item);

  @override
  Future<User> update(int id, User item) async =>
      UserRepo.instance.update(item);
}
