import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/field/reference/cms_reference.dart';

class CmsReferenceModal<T> extends StatefulWidget {
  final String title;
  final String? noDataLabel;
  final CmsReference<T>? reference;
  final Future<List<CmsReference<T>>> Function()? items;
  final Future<List<CmsReference<T>>> Function(String)? search;

  const CmsReferenceModal({
    required this.title,
    required this.reference,
    this.items,
    this.search,
    this.noDataLabel,
    super.key,
  });

  @override
  State<CmsReferenceModal<T>> createState() => _CmsReferenceModalState<T>();
}

class _CmsReferenceModalState<T> extends State<CmsReferenceModal<T>> {
  final _items = <CmsReference<T>>[];

  var _searchQuery = '';
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiModal(
      title: widget.title,
      childPadding: EdgeInsets.zero,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 500,
        ),
        child: ImpaktfullUiAutoLayout.vertical(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ImpaktfullUiInputField(
                label: 'Search',
                value: _searchQuery,
                onChanged: _onSearchChanged,
              ),
            ),
            Expanded(
              flex: 0,
              child: ImpaktfullUiListView.builder(
                items: _items,
                shrinkWrap: true,
                isLoading: _isLoading,
                itemBuilder: (context, item, index) {
                  final itemBuilder = item.itemBuilder;
                  if (itemBuilder != null) {
                    return itemBuilder(
                      context,
                      () => _onItemSelected(item),
                    );
                  }
                  return ImpaktfullUiListItem(
                    leading: item.leading,
                    title: item.title,
                    subtitle: item.subtitle,
                    trailing: item.trailing,
                    onTap: () => _onItemSelected(item),
                  );
                },
                placeholderData: ImpaktfullUiListViewPlaceholderData(
                  title: widget.noDataLabel ?? 'No data found',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemSelected(CmsReference<T> item) =>
      Navigator.of(this.context).pop(item);

  Future<void> _onSearchChanged(String value) async {
    setState(() {
      _searchQuery = value;
      _isLoading = true;
    });
    final searchItems = await widget.search?.call(value);
    if (searchItems != null) {
      _items.clear();
      _items.addAll(searchItems);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getData() async {
    final callBack = widget.items;
    if (callBack == null) return;
    try {
      setState(() => _isLoading = true);
      final items = await callBack();
      _items.clear();
      _items.addAll(items);
    } catch (error, trace) {
      debugPrint(error.toString());
      debugPrint(trace.toString());
    }
    if (!mounted) return;
    setState(() => _isLoading = false);
  }
}
