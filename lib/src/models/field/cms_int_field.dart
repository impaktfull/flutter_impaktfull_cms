import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

class CmsIntField extends CmsField<int> {
  final int? min;
  final int? max;

  CmsIntField({
    required super.id,
    required super.label,
    required int super.initialValue,
    this.min,
    this.max,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) => ImpaktfullUiNumberInput(
        label: label,
        value: value ?? initialValue!,
        min: min,
        max: max,
        onChanged: onChanged,
      );

  @override
  Widget buildRead(BuildContext context) {
    return ImpaktfullUiAutoLayout.vertical(
      children: [
        ImpaktfullUiSectionTitle(
          title: label,
          margin: EdgeInsets.zero,
        ),
        SelectableText(
          value?.toString() ?? '',
          style:
              ImpaktfullUiTheme.of(context).textStyles.onCard.text.small.light,
        ),
      ],
    );
  }
}
