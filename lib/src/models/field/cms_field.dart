import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

export 'cms_bool_field.dart';
export 'cms_int_field.dart';
export 'cms_string_field.dart';
export 'cms_image_url/cms_image_url_field.dart';
export 'reference/cms_reference_field.dart';
export 'icon/cms_icon_field.dart';

abstract class CmsField<T> {
  final _listeners = <CmsFieldListener>{};

  final Enum id;
  final String label;
  String? _error;
  final T? _initialValue;
  final bool isRequired;
  T? _value;

  String? get error => _error;

  T? get value => _value;

  T? get initialValue => _initialValue;

  CmsField({
    required this.id,
    required this.label,
    T? initialValue,
    this.isRequired = false,
  })  : _initialValue = initialValue,
        _value = initialValue;

  Widget buildCreateOrUpdate(BuildContext context);

  Widget buildRead(BuildContext context);

  void onChanged(T value) {
    _value = value;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void addListener(CmsFieldListener listener) {
    _listeners.add(listener);
  }

  void removeListener(CmsFieldListener listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (final listener in _listeners) {
      listener.notifylisteners();
    }
  }
}

abstract class CmsFieldListener {
  void notifylisteners();
}

extension CmsFieldExtension on List<CmsField<dynamic>> {
  CmsField<T> getField<T>(Enum id) {
    final result = firstOrNullWhere((field) => field.id == id);
    if (result == null) {
      throw Exception('Field not found (with id: $id)');
    }
    return result as CmsField<T>;
  }

  String? getString(Enum id) => getField<String>(id).value;

  int? getInt(Enum id) => getField<int>(id).value;

  double? getDouble(Enum id) => getField<double>(id).value!;

  bool? getBool(Enum id) => getField<bool>(id).value!;

  T? getReference<T>(Enum id) {
    final result = getField<CmsReference<T>>(id);
    return result.value?.value;
  }

  CmsIcon<T>? getIcon<T>(Enum id) => getField<CmsIcon<T>>(id).value;

  DateTime? getDateTime(Enum id) => getField<DateTime>(id).value;

  List<T>? getList<T>(Enum id) => getField<List<T>>(id).value;
}
