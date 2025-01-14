import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsAddViewModel<T, E> extends ChangeNotifierEx {
  final CmsNavigator _cmsNavigator;

  late final CmsConfig<T, E> _cmsConfig;

  late final List<CmsField<dynamic>> _fields;

  List<CmsField<dynamic>> get fields => _fields;

  CmsAddViewModel(
    this._cmsNavigator,
  );

  Future<void> init(CmsConfig<T, E> cmsConfig) async {
    _cmsConfig = cmsConfig;
    _fields = _cmsConfig.getFields();
  }

  Future<void> onSaveTapped() async {
    try {
      final item = _cmsConfig.createNewItem(_fields);
      final isSaveable = await _cmsConfig.isSaveable(item);
      if (!isSaveable) {
        return;
      }
      final newUser = await _cmsConfig.saveItem(item);
      _cmsNavigator.goBackWithResult(result: newUser);
    } catch (error, trace) {
      _cmsNavigator.showError(error: error, trace: trace);
    }
  }
}
