import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/field/icon/cms_icon_button.dart';

export 'package:impaktfull_cms/src/models/data/cms_icon.dart';

class CmsIconField<T> extends CmsField<CmsIcon<T>> {
  final String modalTitle;
  final String noDataSelected;
  final String? modalNoDataLabel;
  final Future<List<CmsIcon<T>>> Function()? items;

  CmsIconField({
    required super.id,
    required super.label,
    required this.modalTitle,
    required this.noDataSelected,
    this.modalNoDataLabel,
    super.initialValue,
    this.items,
    super.isRequired = false,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) =>
      ImpaktfullUiAutoLayout.vertical(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImpaktfullUiSectionTitle(
            title: label,
            margin: EdgeInsets.zero,
          ),
          CmsIconButton(
            icon: value,
            items: items,
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
        if (value == null) ...[
          Text(
            noDataSelected,
            style: ImpaktfullUiTheme.of(context)
                .textStyles
                .onCard
                .text
                .small
                .light,
          ),
        ] else ...[
          ImpaktfullUiAssetWidget(
            asset: value!.icon,
          ),
        ],
      ],
    );
  }
}
