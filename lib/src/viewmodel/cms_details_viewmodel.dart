import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsDetailsViewModel<T, E> extends ChangeNotifierEx {
  final CmsNavigator cmsNavigator;

  late final CmsConfig<T, E> _cmsConfig;

  late final List<CmsField<dynamic>> _fields;

  late final T _item;

  List<CmsField<dynamic>> get fields => _fields;

  CmsDetailsViewModel(
    this.cmsNavigator,
  );

  Future<void> initCms(CmsConfig<T, E> cmsConfig, T item) async {
    _cmsConfig = cmsConfig;
    _item = item;
    _fields = _cmsConfig.getFields(
      item: item,
    );
  }

  Future<void> onDeleteTapped() async {
    try {
      final isDeletable = await _cmsConfig.isDeletable(_item);
      if (!isDeletable) {
        return;
      }
      final shouldBeDeleted = await cmsNavigator.showDeleteConfirmation(
        _cmsConfig,
        _item,
      );
      if (shouldBeDeleted != true) return;
      await _cmsConfig.deleteItem(_item);
      cmsNavigator.goBack();
    } catch (error, trace) {
      cmsNavigator.showError(
        message: 'Error deleting item ${T.toString()}',
        error: error,
        trace: trace,
      );
    }
  }
}
