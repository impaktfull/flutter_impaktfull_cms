import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsEditViewModel<T, E> extends ChangeNotifierEx {
  final CmsNavigator _cmsNavigator;

  late final CmsConfig<T, E> _cmsConfig;

  late final List<CmsField<dynamic>> _fields;

  late final T _item;

  List<CmsField<dynamic>> get fields => _fields;

  CmsEditViewModel(
    this._cmsNavigator,
  );

  Future<void> initCms(CmsConfig<T, E> cmsConfig, T item) async {
    _cmsConfig = cmsConfig;
    _item = item;
    _fields = _cmsConfig.getFields(
      item: item,
    );
  }

  Future<void> onSaveTapped() async {
    try {
      final id = _cmsConfig.getId(_item);
      final item = _cmsConfig.updateOldItem(_item, _fields);
      final isSaveable = await _cmsConfig.isSaveable(item);
      if (!isSaveable) {
        return;
      }
      final newItem = await _cmsConfig.updateItem(id, item);
      _cmsNavigator.goBackWithResult(result: newItem);
    } catch (error, trace) {
      _cmsNavigator.showError(
        message: 'Error updating item ${T.toString()}',
        error: error,
        trace: trace,
      );
    }
  }
}
