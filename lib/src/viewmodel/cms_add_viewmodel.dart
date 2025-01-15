import 'package:flutter/foundation.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/navigator/cms_navigator.dart';

class CmsAddViewModel<T, E> extends ChangeNotifierEx {
  @protected
  final CmsNavigator cmsNavigator;

  @protected
  late final CmsConfig<T, E> cmsConfig;

  late final List<CmsField<dynamic>> _fields;

  List<CmsField<dynamic>> get fields => _fields;

  CmsAddViewModel(
    this.cmsNavigator,
  );

  Future<void> initCms(CmsConfig<T, E> cmsConfig) async {
    this.cmsConfig = cmsConfig;
    _fields = cmsConfig.getFields();
  }

  Future<void> onSaveTapped() async {
    try {
      final fields = _fields;
      final missingFields = <CmsField<dynamic>>[];
      for (final field in fields) {
        if (field.requiredValue && field.value == null) {
          missingFields.add(field);
        }
      }
      if (missingFields.isNotEmpty) {
        cmsNavigator.showMissingFieldsError(missingFields);
        return;
      }
      final item = cmsConfig.createNewItem(fields);
      final isSaveable = await cmsConfig.isSaveable(item);
      if (!isSaveable) {
        return;
      }
      final newUser = await cmsConfig.saveItem(item);
      cmsNavigator.goBackWithResult(result: newUser);
    } catch (error, trace) {
      cmsNavigator.showError(
        message: 'Error saving item ${T.toString()}',
        error: error,
        trace: trace,
      );
    }
  }
}
