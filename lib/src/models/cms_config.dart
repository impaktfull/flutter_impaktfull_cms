import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:impaktfull_cms/src/models/data/paging_info.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/models/header/cms_header.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';
import 'package:impaktfull_cms/src/repo/cms_repo.dart';

abstract class CmsConfig<T, E> {
  final CmsNavigator cmsNavigator;
  final CmsRepository<T, E>? _repo;
  final int initialPage;
  final int pageSize;
  final bool defaultAddNewEnabled;

  CmsRepository<T, E> get repo {
    final repo = _repo;
    if (repo == null) {
      throw Exception(
        'CmsRepository<$T, $E> is not configure\nso eighter override the repo methods or configure a repo',
      );
    }
    return repo;
  }

  const CmsConfig({
    required this.cmsNavigator,
    CmsRepository<T, E>? repo,
    this.initialPage = 0,
    this.pageSize = 25,
    this.defaultAddNewEnabled = true,
  }) : _repo = repo;

  E getId(T item);

  String getTitle();

  String? getSubtitle() => null;

  List<CmsHeader> getHeaders();

  List<CmsField<dynamic>> getFields({
    T? item,
  });

  Future<T?> showAdd() => cmsNavigator.showAdd(this);

  Future<T?> showEdit(T item) => cmsNavigator.showEdit(this, item);

  Future<T?> showDetails(T item) => cmsNavigator.showDetails(this, item);

  Future<bool?> showDeleteConfirmation(T item) =>
      cmsNavigator.showDeleteConfirmation(this, item);

  Future<PagingInfo<T>> loadItems({
    required int page,
    required int pageSize,
  }) =>
      repo.loadAll(page: page, pageSize: pageSize);

  Future<T> loadItem(E id) => repo.load(id);

  Future<void> deleteItem(T item) => repo.delete(item);

  Future<T> saveItem(T item) => repo.save(item);

  Future<T> updateItem(E id, T item) => repo.update(id, item);

  FutureOr<bool> isAddNewEnabled() async => defaultAddNewEnabled;

  FutureOr<bool> isEditable(T item) async => true;

  FutureOr<bool> isDeletable(T item) async => true;

  FutureOr<bool> isSaveable(T item) async => true;

  Widget buildRow({
    required T item,
    void Function()? onOpenTapped,
    void Function()? onEditTapped,
    void Function()? onDeleteTapped,
  });

  T createNewItem(List<CmsField<dynamic>> fields);

  T updateOldItem(T item, List<CmsField<dynamic>> fields);
}
