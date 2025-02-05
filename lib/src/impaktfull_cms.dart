import 'package:flutter/widgets.dart';
import 'package:impaktfull_cms/src/models/cms_config.dart';

class ImpaktfullCms {
  final List<CmsConfig<dynamic, dynamic>> _configs = [];

  List<CmsConfig<dynamic, dynamic>> get configs => _configs;

  ImpaktfullCms();

  void register<T, E>(BuildContext context, CmsConfig<T, E> config) {
    final fields = config.getFields(
      context: context,
    );
    final ids = fields.map((field) => field.id).toList();
    final uniqueIds = ids.toSet();
    if (uniqueIds.length != ids.length) {
      throw Exception('Duplicate field IDs detected in CMS config');
    }
    _configs.add(config);
  }

  void unregister<T, E>(CmsConfig<T, E> config) {
    _configs.remove(config);
  }
}
