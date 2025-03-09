import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

class CmsDoubleField extends CmsField<double> {
  final double? min;
  final double? max;

  CmsDoubleField({
    required super.id,
    required super.label,
    required double super.initialValue,
    this.min,
    this.max,
    super.isRequired = false,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) => ImpaktfullUiNumberInput(
        label: label,
        value: value!.toInt(),
        min: min?.toInt(),
        max: max?.toInt(),
        onChanged: (value) => onChanged(value.toDouble()),
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
