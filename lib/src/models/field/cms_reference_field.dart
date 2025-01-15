import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/field/reference/cms_reference_button.dart';

class CmsReferenceField<T> extends CmsField<CmsReference<T>> {
  final String modalTitle;
  final String noDataSelected;
  final String? modalNoDataLabel;
  final List<CmsReference<T>>? items;
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
