import 'package:flutter/widgets.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

class CmsFieldUpdater extends StatefulWidget {
  final CmsField<dynamic> field;

  const CmsFieldUpdater({
    required this.field,
    super.key,
  });

  @override
  State<CmsFieldUpdater> createState() => _CmsFieldUpdaterState();
}

class _CmsFieldUpdaterState extends State<CmsFieldUpdater>
    implements CmsFieldListener {
  @override
  void initState() {
    super.initState();
    widget.field.addListener(this);
  }

  @override
  void dispose() {
    widget.field.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.field.buildCreateOrUpdate(context);
  }

  @override
  void notifylisteners() => setState(() {});
}
