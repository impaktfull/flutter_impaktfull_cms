import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsDetailsViewModel<T, E> extends ChangeNotifierEx {
  @protected
  final CmsNavigator cmsNavigator;

  @protected
  late final CmsConfig<T, E> cmsConfig;

  late final List<CmsField<dynamic>> _fields;

  late T _item;

  var _isDeletable = false;

  List<CmsField<dynamic>> get fields => _fields;

  bool get isDeletable => _isDeletable;

  CmsDetailsViewModel(
    this.cmsNavigator,
  );

  Future<void> initCms(
      BuildContext context, CmsConfig<T, E> cmsConfig, T item) async {
    this.cmsConfig = cmsConfig;
    _item = item;
    _fields = cmsConfig.getFields(
      context: context,
      item: item,
    );
    _isDeletable = await cmsConfig.isDeletable(item);
    notifyListeners();
  }

  Future<void> onDeleteTapped() async {
    try {
      final isDeletable = await cmsConfig.isDeletable(_item);
      if (!isDeletable) {
        return;
      }
      final shouldBeDeleted = await cmsNavigator.showDeleteConfirmation(
        cmsConfig,
        _item,
      );
      if (shouldBeDeleted != true) return;
      await cmsConfig.deleteItem(_item);
      cmsNavigator.goBackWithResult(result: true);
    } catch (error, trace) {
      cmsNavigator.showError(
        message: 'Error deleting item ${T.toString()}',
        error: error,
        trace: trace,
      );
    }
  }

  Future<void> onUpdateTapped() async {
    final updatedItem = await cmsNavigator.showEdit(cmsConfig, _item);
    if (updatedItem == null) return;
    cmsNavigator.goBackWithResult(result: updatedItem);
  }
}
