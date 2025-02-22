import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/src/ui/field/image_url/image_url_modal.dart';
import 'package:impaktfull_cms/src/ui/field/image_url/image_url_preview.dart';

class ImageUrlPicker extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? url;
  final double aspectRatio;
  final BoxFit fit;
  final double? maxWidth;
  final double? maxHeight;

  const ImageUrlPicker({
    required this.url,
    required this.aspectRatio,
    required this.fit,
    required this.maxWidth,
    required this.maxHeight,
    required this.onChanged,
    super.key,
  });

  @override
  State<ImageUrlPicker> createState() => _ImageUrlPickerState();
}

class _ImageUrlPickerState extends State<ImageUrlPicker> {
  String? _url;

  @override
  void initState() {
    super.initState();
    _url = widget.url;
  }

  @override
  void didUpdateWidget(covariant ImageUrlPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _url = widget.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ImpaktfullUiTheme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: widget.maxWidth ?? double.infinity,
        maxHeight: widget.maxHeight ?? double.infinity,
      ),
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Builder(builder: (context) {
          final url = _url;
          if (url != null) {
            return Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                ImageUrlPreview(
                  url: url,
                  aspectRatio: widget.aspectRatio,
                  fit: widget.fit,
                  maxWidth: widget.maxWidth,
                  maxHeight: widget.maxHeight,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.shadow,
                    borderRadius: theme.dimens.borderRadiusCircle,
                  ),
                  child: ImpaktfullUiIconButton(
                    asset: theme.assets.icons.edit,
                    onTap: () => _onTap(context),
                    color: theme.colors.textOnAccent,
                  ),
                ),
              ],
            );
          }
          return ImpaktfullUiTouchFeedback(
            borderRadius: theme.dimens.borderRadius,
            border: Border.all(
              color: theme.colors.border,
            ),
            onTap: () => _onTap(context),
            child: ImpaktfullUiAssetWidget(
              asset: theme.assets.icons.edit,
            ),
          );
        }),
      ),
    );
  }

  Future<void> _onTap(BuildContext context) async {
    final result = await ImpaktfullUiModal.show(
      context: context,
      builder: (context) => ImpaktfullUrlModal(
        url: widget.url,
      ),
    );
    if (result == null) return;
    setState(() {
      _url = result;
    });
    widget.onChanged(result);
  }
}
