import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';

export 'cms_string_field.dart';
export 'cms_int_field.dart';

abstract class CmsField<T> {
  final _listeners = <CmsFieldListener>{};

  final Enum id;
  final String label;
  String? _error;
  final T? _initialValue;
  T? _value;

  String? get error => _error;

  T? get value => _value;

  T? get initialValue => _initialValue;

  CmsField({
    required this.id,
    required this.label,
    T? initialValue,
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

  CmsField<String> getStringField(Enum id) => getField<String>(id);

  CmsField<int> getIntField(Enum id) => getField<int>(id);

  CmsField<double> getDoubleField(Enum id) => getField<double>(id);

  CmsField<bool> getBoolField(Enum id) => getField<bool>(id);

  CmsField<DateTime> getDateTimeField(Enum id) => getField<DateTime>(id);

  CmsField<List<T>> getListField<T>(Enum id) => getField<List<T>>(id);
}
