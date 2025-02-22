import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

class CmsStringField extends CmsField<String> {
  final bool obscureText;
  final bool readOnly;

  CmsStringField({
    required super.id,
    required super.label,
    super.initialValue,
    this.readOnly = false,
    this.obscureText = false,
    super.isRequired = false,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) {
    return ImpaktfullUiInputField(
      label: label,
      value: value,
      obscureText: obscureText,
      readOnly: readOnly,
      onChanged: onChanged,
    );
  }

  @override
  Widget buildRead(BuildContext context) {
    return ImpaktfullUiAutoLayout.vertical(
      children: [
        ImpaktfullUiSectionTitle(
          title: label,
          margin: EdgeInsets.zero,
        ),
        SelectableText(
          value ?? '',
          style:
              ImpaktfullUiTheme.of(context).textStyles.onCard.text.small.light,
        ),
      ],
    );
  }
}
