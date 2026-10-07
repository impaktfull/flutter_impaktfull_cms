import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

enum _Header { name, email }

class _Call {
  final int page;
  final String? searchQuery;
  final CmsSort? sort;
  final Completer<PagingInfo<String>> completer = Completer();

  _Call(this.page, this.searchQuery, this.sort);
}

class _Repo extends CmsRepository<String, String> {
  final calls = <_Call>[];

  @override
  Future<PagingInfo<String>> loadAll({
    required int page,
    required int pageSize,
    String? searchQuery,
    CmsSort? sort,
  }) {
    final call = _Call(page, searchQuery, sort);
    calls.add(call);
    return call.completer.future;
  }

  @override
  Future<void> delete(String item) => throw UnimplementedError();

  @override
  Future<String> load(String id) => throw UnimplementedError();

  @override
  Future<String> save(String item) => throw UnimplementedError();

  @override
  Future<String> update(String id, String item) => throw UnimplementedError();
}

class _Navigator extends CmsNavigator {
  @override
  void goBack() {}

  @override
  void goBackWithResult<T>({required T result}) {}

  @override
  Future<T?> showAdd<T, E>(CmsConfig<T, E> config) async => null;

  @override
  Future<bool?> showDeleteConfirmation<T, E>(
          CmsConfig<T, E> config, T item) async =>
      null;

  @override
  Future<T?> showDetails<T, E>(CmsConfig<T, E> config, T item) async => null;

  @override
  Future<T?> showEdit<T, E>(CmsConfig<T, E> config, T item) async => null;

  @override
  void showError({
    required String message,
    required Object error,
    required StackTrace trace,
  }) {}

  @override
  void showMissingFieldsError(List<CmsField<dynamic>> missingFields) {}
}

class _Config extends CmsConfig<String, String> {
  _Config({required super.cmsNavigator, required super.repo})
      : super(pageSize: 2);

  @override
  bool get isSearchEnabled => true;

  @override
  String getId(String item) => item;

  @override
  String getTitle({required BuildContext context}) => 'Items';

  @override
  List<CmsHeader> getHeaders({required BuildContext context}) => const [
        CmsHeader(id: _Header.name, title: 'Name', isSortable: true),
        CmsHeader(id: _Header.email, title: 'Email', isSortable: true),
      ];

  @override
  List<CmsField<dynamic>> getFields({
    required BuildContext context,
    String? item,
  }) =>
      [];

  @override
  Widget buildRow({
    required BuildContext context,
    required String item,
    void Function()? onOpenTapped,
    void Function()? onEditTapped,
    void Function()? onDeleteTapped,
  }) =>
      Text(item);

  @override
  String createNewItem(List<CmsField<dynamic>> fields) =>
      throw UnimplementedError();

  @override
  String updateOldItem(String item, List<CmsField<dynamic>> fields) =>
      throw UnimplementedError();
}

PagingInfo<String> _paging(List<String> items, {int totalPage = 3}) =>
    PagingInfo(items: items, page: 0, pageSize: 2, totalPage: totalPage);

void main() {
  late _Repo repo;
  late CmsListViewModel<String, String> viewModel;

  const nameHeader =
      CmsHeader(id: _Header.name, title: 'Name', isSortable: true);
  const emailHeader =
      CmsHeader(id: _Header.email, title: 'Email', isSortable: true);

  Future<void> init(WidgetTester tester) async {
    repo = _Repo();
    viewModel = CmsListViewModel<String, String>(_Navigator());
    await tester.pumpWidget(
      Builder(
        builder: (context) {
          viewModel.initCms(
            context,
            _Config(cmsNavigator: _Navigator(), repo: repo),
          );
          return const SizedBox();
        },
      ),
    );
    await tester.pump();
    repo.calls.last.completer.complete(_paging(['a', 'b']));
    await tester.pump();
  }

  testWidgets('sort cycles ascending -> descending -> default', (tester) async {
    await init(tester);
    expect(viewModel.isSearchEnabled, isTrue);

    viewModel.onLoadPage(2);
    await tester.pump();
    expect(repo.calls.last.page, 2);

    viewModel.onSortTapped(nameHeader);
    await tester.pump();
    expect(repo.calls.last.page, 0);
    expect(
      repo.calls.last.sort,
      const CmsSort(headerId: _Header.name, ascending: true),
    );
    expect(viewModel.isSortAscending(nameHeader), isTrue);
    expect(viewModel.isSortAscending(emailHeader), isNull);

    viewModel.onSortTapped(nameHeader);
    await tester.pump();
    expect(
      repo.calls.last.sort,
      const CmsSort(headerId: _Header.name, ascending: false),
    );
    expect(viewModel.isSortAscending(nameHeader), isFalse);

    viewModel.onSortTapped(nameHeader);
    await tester.pump();
    expect(repo.calls.last.sort, isNull);
    expect(viewModel.isSortAscending(nameHeader), isNull);
  });

  testWidgets('tapping another header starts ascending on that header',
      (tester) async {
    await init(tester);
    viewModel.onSortTapped(nameHeader);
    viewModel.onSortTapped(nameHeader);
    viewModel.onSortTapped(emailHeader);
    await tester.pump();
    expect(
      repo.calls.last.sort,
      const CmsSort(headerId: _Header.email, ascending: true),
    );
  });

  testWidgets('search is debounced, trimmed and resets to page 0',
      (tester) async {
    await init(tester);
    viewModel.onLoadPage(1);
    await tester.pump();
    final callsBefore = repo.calls.length;

    viewModel.onSearchQueryChanged('ge');
    viewModel.onSearchQueryChanged('gent ');
    expect(viewModel.searchQuery, 'gent ');
    await tester.pump(const Duration(milliseconds: 100));
    expect(repo.calls.length, callsBefore);

    await tester.pump(CmsListViewModel.searchDebounceDuration);
    expect(repo.calls.length, callsBefore + 1);
    expect(repo.calls.last.searchQuery, 'gent');
    expect(repo.calls.last.page, 0);

    viewModel.onSearchQueryChanged('  ');
    await tester.pump(CmsListViewModel.searchDebounceDuration);
    expect(repo.calls.last.searchQuery, isNull);
  });

  testWidgets('an older response does not overwrite a newer one',
      (tester) async {
    await init(tester);
    viewModel.onLoadPage(1);
    await tester.pump();
    final olderCall = repo.calls.last;
    viewModel.onSortTapped(nameHeader);
    await tester.pump();
    final newerCall = repo.calls.last;

    newerCall.completer.complete(_paging(['newer'], totalPage: 1));
    await tester.pump();
    olderCall.completer.complete(_paging(['older'], totalPage: 5));
    await tester.pump();

    expect(viewModel.totalItems, 2);
    expect(viewModel.isLoading, isFalse);
  });
}
