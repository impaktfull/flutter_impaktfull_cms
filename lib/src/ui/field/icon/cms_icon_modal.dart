import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/models/field/icon/cms_icon.dart';

class CmsIconModal extends StatefulWidget {
  final String title;
  final String? noDataLabel;
  final CmsIcon? icon;
  final Color? color;
  final Future<List<CmsIcon>> Function()? items;

  const CmsIconModal({
    required this.title,
    required this.icon,
    this.color,
    this.items,
    this.noDataLabel,
    super.key,
  });

  @override
  State<CmsIconModal> createState() => _CmsIconModalState();
}

class _CmsIconModalState extends State<CmsIconModal> {
  final _items = <CmsIcon>[];

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
        child: ImpaktfullUiListView.builder(
          items: _items,
          shrinkWrap: true,
          isLoading: _isLoading,
          itemBuilder: (context, item, index) {
            final name = item.name ?? '';
            if (name.isEmpty) {
              return Center(
                child: ImpaktfullUiIconButton(
                  asset: item.icon,
                  onTap: () => _onItemSelected(item),
                ),
              );
            }
            return ImpaktfullUiTouchFeedback(
              onTap: () => _onItemSelected(item),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: ImpaktfullUiAutoLayout.horizontal(
                  spacing: 8,
                  children: [
                    ImpaktfullUiAssetWidget(
                      asset: item.icon,
                    ),
                    if (name.isNotEmpty) ...[
                      Text(
                        name,
                        style: ImpaktfullUiTheme.of(context)
                            .components
                            .simpleListItem
                            .textStyles
                            .title,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
          noDataLabel: widget.noDataLabel ?? 'No data found',
        ),
      ),
    );
  }

  void _onItemSelected(CmsIcon item) => Navigator.of(this.context).pop(item);

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
