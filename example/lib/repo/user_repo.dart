import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/data/user.dart';

class UserRepo {
  final _users = <User>[];
  static UserRepo? _instance;

  static UserRepo get instance => _instance ??= UserRepo();

  Future<User> save(User user) async {
    await _performNetworkDelay();
    _users.add(user);
    return user;
  }

  Future<User> update(User user) async {
    await _performNetworkDelay();
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index == -1) {
      throw Exception('User not found');
    }
    _users[index] = user;
    return user;
  }

  Future<void> delete(User user) async {
    await _performNetworkDelay();
    _users.remove(user);
  }

  Future<PagingInfo<User>> getUsers({
    int page = 0,
    int pageSize = 10,
    String? searchQuery,
    CmsSort? sort,
  }) async {
    await _performNetworkDelay();
    final start = page * pageSize;
    final end = start + pageSize;
    var allUsers = [..._users];
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      allUsers = allUsers
          .where(
            (user) => user.name.toLowerCase().contains(query),
          )
          .toList();
    }
    if (sort != null) {
      final headerId = sort.headerId;
      final sortName = headerId is Enum ? headerId.name : headerId.toString();
      String getValue(User user) => switch (sortName) {
            'email' => user.email,
            _ => user.name,
          };
      allUsers.sort((a, b) {
        final result = getValue(a).compareTo(getValue(b));
        return sort.ascending ? result : -result;
      });
    }
    final users = allUsers.sublist(
      start > allUsers.length ? allUsers.length : start,
      end > allUsers.length ? allUsers.length : end,
    );
    return PagingInfo(
      items: users,
      page: page,
      pageSize: pageSize,
      totalPage: (allUsers.length / pageSize).ceil(),
    );
  }

  Future<User> getUser(int id) async {
    return _users.firstWhere((user) => user.id == id);
  }

  Future<void> _performNetworkDelay() async =>
      Future.delayed(const Duration(seconds: 1));
}
