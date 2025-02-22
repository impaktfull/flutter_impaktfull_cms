import 'package:impaktfull_architecture/impaktfull_architecture.dart';

class CmsIcon<T> {
  final ImpaktfullUiAsset icon;
  final String? name;
  final T? value;

  const CmsIcon({
    required this.icon,
    this.name,
    this.value,
  });
}
