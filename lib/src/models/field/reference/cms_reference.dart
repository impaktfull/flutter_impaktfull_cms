import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';

class CmsReference<T> {
  final String title;
  final String? subtitle;
  final T value;
  final ImpaktfullUiAsset? trailing;
  final ImpaktfullUiAsset? leading;

  final Widget Function(
    BuildContext context,
    VoidCallback onTap,
  )? selectedItemBuilder;
  final Widget Function(
    BuildContext context,
    VoidCallback onTap,
  )? itemBuilder;

  const CmsReference({
    required this.title,
    required this.value,
    this.subtitle,
    this.selectedItemBuilder,
    this.itemBuilder,
    this.leading,
    this.trailing,
  });
}
