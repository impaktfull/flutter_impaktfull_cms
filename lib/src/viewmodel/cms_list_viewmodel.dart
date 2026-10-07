import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/header/cms_header.dart';
import 'package:impaktfull_cms/src/models/sort/cms_sort.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsListViewModel<T, E> extends ChangeNotifierEx {
  static const searchDebounceDuration = Duration(milliseconds: 300);

  @protected
  final CmsNavigator cmsNavigator;

  @protected
  late final CmsConfig<T, E> cmsConfig;

  final _items = <T>[];
  var _title = '';
  String? _subtitle;
  var _headers = <CmsHeader>[];
  CmsSort? _sort;
  var _searchQuery = '';
  Timer? _searchDebounce;
  var _requestId = 0;
  var _page = 0;
  var _totalPages = 0;
  var _isLoading = false;
  var _isAddNewEnabled = true;
  var _isSearchEnabled = false;

  String get title => _title;

  String? get subtitle => _subtitle;

  List<CmsHeader> get headers => _headers;

  bool get isLoading => _isLoading;

  bool get isAddNewEnabled => _isAddNewEnabled;

  bool get isSearchEnabled => _isSearchEnabled;

  String get searchQuery => _searchQuery;

  CmsSort? get sort => _sort;

  List<Widget> getRows(BuildContext context) {
    if (_items.isEmpty) return [];
    return _items
        .map(
          (item) => cmsConfig.buildRow(
            context: context,
            item: item,
            onOpenTapped: () => onOpenTapped(item),
            onEditTapped: () => onEditTapped(item),
            onDeleteTapped: () => onDeleteTapped(item),
          ),
        )
        .toList();
  }

  int get page => _page;

  int get pageSize => cmsConfig.pageSize;

  int get totalItems => _totalPages * pageSize;

  CmsListViewModel(
    this.cmsNavigator,
  );

  Future<void> initCms(BuildContext context, CmsConfig<T, E> cmsConfig) async {
    this.cmsConfig = cmsConfig;
    _title = cmsConfig.getTitle(context: context);
    _subtitle = cmsConfig.getSubtitle(context: context);
    _headers = cmsConfig.getHeaders(context: context);
    _isSearchEnabled = cmsConfig.isSearchEnabled;
    _loadData();
  }

  Future<void> onRefresh() async {
    _page = 0;
    _items.clear();
    _loadData();
  }

  Future<void> loadMore() async {
    if (_page >= _totalPages) return;
    _page++;
    _loadData();
  }

  Future<void> _loadData() async {
    if (disposed) return;
    final requestId = ++_requestId;
    try {
      _isLoading = true;
      notifyListeners();
      _isAddNewEnabled = await cmsConfig.isAddNewEnabled();
      final searchQuery = _searchQuery.trim();
      final pagingInfo = await cmsConfig.loadItems(
        page: _page,
        pageSize: cmsConfig.pageSize,
        searchQuery: searchQuery.isEmpty ? null : searchQuery,
        sort: _sort,
      );
      // A newer request was started (e.g. search or sort changed), ignore this result
      if (requestId != _requestId) return;
      _totalPages = pagingInfo.totalPage;
      _items.clear();
      _items.addAll(pagingInfo.items);
    } catch (error, trace) {
      if (requestId != _requestId) return;
      cmsNavigator.showError(
        message: 'Error loading items ${T.toString()}',
        error: error,
        trace: trace,
      );
    }
    if (disposed) return;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> onAddTapped() async {
    final showAddButton = await cmsConfig.isAddNewEnabled();
    if (!showAddButton) return;
    final result = await cmsConfig.showAdd();
    if (result == null) return;
    onLoadPage(0);
  }

  Future<void> onOpenTapped(T item) async {
    final result = await cmsConfig.showDetails(item);
    if (result == item) return;
    onLoadPage(0);
  }

  Future<void> onEditTapped(T item) async {
    final isEditable = await cmsConfig.isEditable(item);
    if (!isEditable) return;
    final result = await cmsConfig.showEdit(item);
    if (result == item) return;
    onLoadPage(0);
  }

  Future<void> onDeleteTapped(T item) async {
    final isDeletable = await cmsConfig.isDeletable(item);
    if (!isDeletable) return;
    final result = await cmsConfig.showDeleteConfirmation(item);
    if (result != true) return;
    await cmsConfig.deleteItem(item);
    onLoadPage(0);
  }

  /// Cycles the sort of a header: ascending -> descending -> default (no sort)
  /// Tapping another header starts sorting ascending on that header
  void onSortTapped(CmsHeader cmsHeader) {
    if (!cmsHeader.isSortable) return;
    final sort = _sort;
    if (sort == null || sort.headerId != cmsHeader.id) {
      _sort = CmsSort(headerId: cmsHeader.id, ascending: true);
    } else if (sort.ascending) {
      _sort = CmsSort(headerId: cmsHeader.id, ascending: false);
    } else {
      _sort = null;
    }
    onLoadPage(0);
  }

  bool? isSortAscending(CmsHeader cmsHeader) {
    if (!cmsHeader.isSortable) return null;
    final sort = _sort;
    if (sort == null) return null;
    if (sort.headerId != cmsHeader.id) return null;
    return sort.ascending;
  }

  void onSearchQueryChanged(String value) {
    if (value == _searchQuery) return;
    _searchQuery = value;
    notifyListeners();
    _searchDebounce?.cancel();
    _searchDebounce = Timer(searchDebounceDuration, () => onLoadPage(0));
  }

  void onLoadPage(int value) {
    _page = value;
    _items.clear();
    _loadData();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
