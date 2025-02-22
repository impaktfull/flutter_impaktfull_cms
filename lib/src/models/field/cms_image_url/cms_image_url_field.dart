import 'package:flutter/material.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/field/image_url/image_url_picker.dart';
import 'package:impaktfull_cms/src/ui/field/image_url/image_url_preview.dart';

class CmsImageUrlField extends CmsField<String> {
  final double aspectRatio;
  final double? maxWidth;
  final double? maxHeight;
  final BoxFit fit;

  CmsImageUrlField.url({
    required super.id,
    required super.label,
    super.initialValue,
    super.isRequired = false,
    this.aspectRatio = 1,
    this.fit = BoxFit.contain,
    this.maxWidth = 150,
    this.maxHeight = 150,
  });

  @override
  Widget buildCreateOrUpdate(BuildContext context) {
    return ImpaktfullUiAutoLayout.vertical(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        ImpaktfullUiSectionTitle(
          title: label,
          margin: EdgeInsets.zero,
        ),
        ImageUrlPicker(
          url: value,
          aspectRatio: aspectRatio,
          fit: fit,
          maxWidth: maxWidth,
          maxHeight: maxHeight,
          onChanged: onChanged,
        ),
      ],
    );
  }

  @override
  Widget buildRead(BuildContext context) {
    return ImpaktfullUiAutoLayout.vertical(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 4,
      children: [
        ImpaktfullUiSectionTitle(
          title: label,
          margin: EdgeInsets.zero,
        ),
        if (value == null) ...[
          Text(
            'N/A',
            style: ImpaktfullUiTheme.of(context)
                .textStyles
                .onCard
                .text
                .small
                .light,
          ),
        ] else ...[
          ImageUrlPreview(
            url: value!,
            aspectRatio: aspectRatio,
            fit: fit,
            maxWidth: maxWidth,
            maxHeight: maxHeight,
          ),
        ],
      ],
    );
  }
}
