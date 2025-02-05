import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsEditViewModel<T, E> extends ChangeNotifierEx {
  @protected
  final CmsNavigator cmsNavigator;

  @protected
  late final CmsConfig<T, E> cmsConfig;

  late final List<CmsField<dynamic>> _fields;

  late final T _item;

  List<CmsField<dynamic>> get fields => _fields;

  CmsEditViewModel(
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
  }

  Future<void> onSaveTapped() async {
    try {
      final id = cmsConfig.getId(_item);
      final item = cmsConfig.updateOldItem(_item, _fields);
      final isSaveable = await cmsConfig.isSaveable(item);
      if (!isSaveable) {
        return;
      }
      final newItem = await cmsConfig.updateItem(id, item);
      if (disposed) return;
      cmsNavigator.goBackWithResult(result: newItem);
    } catch (error, trace) {
      cmsNavigator.showError(
        message: 'Error updating item ${T.toString()}',
        error: error,
        trace: trace,
      );
    }
  }
}
