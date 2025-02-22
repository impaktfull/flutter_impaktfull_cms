import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';

class ImpaktfullUrlModal extends StatefulWidget {
  final String? url;

  const ImpaktfullUrlModal({
    super.key,
    required this.url,
  });

  @override
  State<ImpaktfullUrlModal> createState() => _ImpaktfullUrlModalState();
}

class _ImpaktfullUrlModalState extends State<ImpaktfullUrlModal> {
  var _url = '';

  @override
  void initState() {
    super.initState();
    _url = widget.url ?? '';
  }

  void onChanged(String value) {
    setState(() => _url = value);
  }

  @override
  Widget build(BuildContext context) {
    return ImpaktfullUiModal(
      title: 'Photo url',
      showDividers: true,
      actions: [
        ImpaktfullUiButton(
          type: ImpaktfullUiButtonType.primary,
          title: 'Save',
          onTap: () => Navigator.of(context).pop(_url),
        ),
      ],
      child: ImpaktfullUiInputField(
        label: 'Photo url',
        value: widget.url,
        onChanged: onChanged,
      ),
    );
  }
}
