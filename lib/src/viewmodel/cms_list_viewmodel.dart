import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/header/cms_header.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsListViewModel<T, E> extends ChangeNotifierEx {
  @protected
  final CmsNavigator cmsNavigator;

  @protected
  late final CmsConfig<T, E> cmsConfig;

  final _items = <T>[];
  var _title = '';
  String? _subtitle;
  var _headers = <CmsHeader>[];
  CmsHeader? _sortCmsHeader;
  bool? _sortAscending;
  var _page = 0;
  var _totalPages = 0;
  var _isLoading = false;
  var _isAddNewEnabled = true;

  String get title => _title;

  String? get subtitle => _subtitle;

  List<CmsHeader> get headers => _headers;

  bool get isLoading => _isLoading;

  bool get isAddNewEnabled => _isAddNewEnabled;

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
    try {
      _isLoading = true;
      notifyListeners();
      _isAddNewEnabled = await cmsConfig.isAddNewEnabled();
      final pagingInfo = await cmsConfig.loadItems(
        page: _page,
        pageSize: cmsConfig.pageSize,
      );
      _totalPages = pagingInfo.totalPage;
      _items.clear();
      _items.addAll(pagingInfo.items);
    } catch (error, trace) {
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
    await cmsConfig.showDetails(item);
    onLoadPage(0);
  }

  Future<void> onEditTapped(T item) async {
    final isEditable = await cmsConfig.isEditable(item);
    if (!isEditable) return;
    final result = await cmsConfig.showEdit(item);
    if (result == null) return;
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

  void onSortTapped(CmsHeader cmsHeader) {
    debugPrint('Sorting not yet 100% implemented');
    // final sortCmsHeader = _sortCmsHeader;
    // if (sortCmsHeader == null) {
    //   _sortCmsHeader = cmsHeader;
    //   _sortAscending = true;
    // } else if (sortCmsHeader.id != cmsHeader.id) {
    //   _sortCmsHeader = cmsHeader;
    //   _sortAscending = true;
    // } else {
    //   if (_sortAscending == true) {
    //     _sortAscending = false;
    //   } else if (_sortAscending == false) {
    //     _sortAscending = null;
    //   } else {
    //     _sortAscending = true;
    //   }
    // }
    // notifyListeners();
  }

  bool? isSortAscending(CmsHeader cmsHeader) {
    if (!cmsHeader.isSortable) return null;
    final sortHeader = _sortCmsHeader;
    if (sortHeader == null) return null;
    if (sortHeader.id != cmsHeader.id) return null;
    return _sortAscending;
  }

  void onLoadPage(int value) {
    _page = value;
    _items.clear();
    _loadData();
  }
}
