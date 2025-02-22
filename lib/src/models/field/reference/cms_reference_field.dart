import 'package:flutter/material.dart';
import 'package:impaktfull_cms/src/models/field/cms_field.dart';
import 'package:impaktfull_cms/src/ui/field/reference/cms_reference_button.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

export 'package:impaktfull_cms/src/models/field/reference/cms_reference.dart';

class CmsReferenceField<T> extends CmsField<CmsReference<T>> {
  final String modalTitle;
  final String noDataSelected;
  final String? modalNoDataLabel;
  final Future<List<CmsReference<T>>> Function()? items;
  final Future<List<CmsReference<T>>> Function(String)? search;

  CmsReferenceField({
    required super.id,
    required super.label,
    required this.modalTitle,
    required this.noDataSelected,
    this.modalNoDataLabel,
    super.initialValue,
    this.items,
    this.search,
    super.isRequired = false,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) =>
      ImpaktfullUiAutoLayout.vertical(
        spacing: 4,
        children: [
          ImpaktfullUiSectionTitle(
            title: label,
            margin: EdgeInsets.zero,
          ),
          CmsReferenceButton(
            reference: value,
            items: items,
            search: search,
            noDataSelected: noDataSelected,
            modalTitle: modalTitle,
            modalNoDataLabel: modalNoDataLabel,
            onChanged: onChanged,
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
        SelectableText(
          value?.title ?? '',
          style:
              ImpaktfullUiTheme.of(context).textStyles.onCard.text.small.light,
        ),
      ],
    );
  }
}
