import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/data/cms_icon.dart';
import 'package:impaktfull_cms/src/ui/field/icon/cms_icon_modal.dart';

class CmsIconButton<T> extends StatelessWidget {
  final String modalTitle;
  final String noDataSelected;
  final String? modalNoDataLabel;
  final CmsIcon<T>? icon;
  final Future<List<CmsIcon<T>>> Function()? items;
  final void Function(CmsIcon<T>) onChanged;

  const CmsIconButton({
    required this.modalTitle,
    required this.noDataSelected,
    required this.icon,
    required this.onChanged,
    this.modalNoDataLabel,
    this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return ImpaktfullUiButton(
        type: ImpaktfullUiButtonType.secondaryGrey,
        leadingAsset: icon!.icon,
        onAsyncTap: () => _onSelectTapped(context),
      );
    }
    return ImpaktfullUiButton(
      type: ImpaktfullUiButtonType.secondaryGrey,
      fullWidth: true,
      title: noDataSelected,
      onAsyncTap: () => _onSelectTapped(context),
    );
  }

  Future<void> _onSelectTapped(BuildContext context) async {
    final result = await ImpaktfullUiModal.show<CmsIcon<T>>(
      context: context,
      builder: (context) => CmsIconModal(
        title: modalTitle,
        noDataLabel: modalNoDataLabel,
        icon: icon,
        items: items,
      ),
    );
    if (result == null) return;
    onChanged(result);
  }
}
