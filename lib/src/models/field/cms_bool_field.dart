import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

class CmsBoolField extends CmsField<bool> {
  final String? labelSelected;
  final String? labelUnselected;

  CmsBoolField({
    required super.id,
    required super.label,
    required bool super.initialValue,
    this.labelSelected,
    this.labelUnselected,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) =>
      ImpaktfullUiAutoLayout.vertical(
        children: [
          ImpaktfullUiSectionTitle(
            title: label,
            margin: EdgeInsets.zero,
          ),
          GestureDetector(
            onTap: () => onChanged(!value!),
            child: ImpaktfullUiAutoLayout.horizontal(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                if (labelUnselected != null) ...[
                  Expanded(
                    child: Text(
                      labelUnselected!,
                      style: ImpaktfullUiTheme.of(context)
                          .textStyles
                          .onCard
                          .text
                          .small
                          .light,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
                ImpaktfullUiSwitch(
                  value: value!,
                  onChanged: onChanged,
                ),
                if (labelSelected != null) ...[
                  Expanded(
                    child: Text(
                      labelSelected!,
                      style: ImpaktfullUiTheme.of(context)
                          .textStyles
                          .onCard
                          .text
                          .small
                          .light,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );

  @override
  Widget buildRead(BuildContext context) {
    return ImpaktfullUiAutoLayout.vertical(
      children: [
        ImpaktfullUiSectionTitle(
          title: label,
          margin: EdgeInsets.zero,
        ),
        ImpaktfullUiSwitch(
          value: value ?? false,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
