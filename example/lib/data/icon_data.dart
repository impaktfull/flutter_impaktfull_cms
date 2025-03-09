import 'package:flutter/material.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class CmsIconData {
  static final list = <CmsIcon<String>>[
    const CmsIcon(
      icon: ImpaktfullUiAsset.icon(Icons.arrow_back),
      name: 'Arrow back',
      value: 'arrow_back',
    ),
    const CmsIcon(
      icon: ImpaktfullUiAsset.icon(Icons.arrow_upward),
      name: 'Arrow upward',
      value: 'arrow_upward',
    ),
    const CmsIcon(
      icon: ImpaktfullUiAsset.icon(Icons.arrow_downward),
      name: 'Arrow downward',
      value: 'arrow_downward',
    ),
    const CmsIcon(
      icon: ImpaktfullUiAsset.icon(Icons.arrow_forward),
      name: 'Arrow forward',
      value: 'arrow_forward',
    ),
    const CmsIcon(
      icon: ImpaktfullUiAsset.icon(Icons.chevron_right),
      value: 'chevron_right',
    ),
  ];
}
