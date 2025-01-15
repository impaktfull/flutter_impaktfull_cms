import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/data/cms_reference.dart';
import 'package:impaktfull_cms/src/ui/field/reference/cms_reference_modal.dart';

class CmsReferenceButton<T> extends StatelessWidget {
  final String modalTitle;
  final String noDataSelected;
  final String? modalNoDataLabel;
  final CmsReference<T>? reference;
  final List<CmsReference<T>>? items;
  final Future<List<CmsReference<T>>> Function(String)? search;
  final void Function(CmsReference<T>) onChanged;

  const CmsReferenceButton({
    required this.modalTitle,
    required this.noDataSelected,
    required this.reference,
    required this.onChanged,
    this.modalNoDataLabel,
    this.items,
    this.search,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedItemBuilder = reference?.selectedItemBuilder;
    if (selectedItemBuilder != null) {
      return selectedItemBuilder(
        context,
        () => _onSelectTapped(context),
      );
    }
    return ImpaktfullUiButton(
      type: ImpaktfullUiButtonType.secondaryGrey,
      fullWidth: true,
      title: reference?.title ?? noDataSelected,
      onAsyncTap: () => _onSelectTapped(context),
    );
  }

  Future<void> _onSelectTapped(BuildContext context) async {
    final result = await ImpaktfullUiModal.show<CmsReference<T>>(
      context: context,
      builder: (context) => CmsReferenceModal(
        title: modalTitle,
        noDataLabel: modalNoDataLabel,
        reference: reference,
        items: items,
        search: search,
      ),
    );
    if (result == null) return;
    onChanged(result);
  }
}
