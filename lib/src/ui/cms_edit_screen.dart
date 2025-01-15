import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/cms_updater.dart';
import 'package:impaktfull_cms/src/viewmodel/cms_edit_viewmodel.dart';

class CmsEditScreen<T, E> extends StatelessWidget {
  final CmsNavigator cmsNavigator;
  final CmsConfig<T, E> config;
  final T item;
  final Widget Function(BuildContext context, CmsEditViewModel<T, E> viewModel)?
      builder;

  const CmsEditScreen({
    required this.cmsNavigator,
    required this.config,
    required this.item,
    this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CmsEditViewModel<T, E>>(
      create: (context) =>
          CmsEditViewModel(cmsNavigator)..initCms(config, item),
      child: Consumer<CmsEditViewModel<T, E>>(
        builder: (context, viewModel, child) {
          if (builder != null) {
            return builder!(context, viewModel);
          }
          return ImpaktfullUiAutoLayout.vertical(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                flex: 0,
                child: ImpaktfullUiListView.builder(
                  items: viewModel.fields,
                  padding: const EdgeInsets.all(16),
                  spacing: 8,
                  shrinkWrap: true,
                  itemBuilder: (context, field, index) => CmsFieldUpdater(
                    field: field,
                  ),
                  noDataLabel: 'No fields',
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 16,
                  end: 16,
                  bottom: 16,
                ),
                child: ImpaktfullUiButton(
                  type: ImpaktfullUiButtonType.primary,
                  fullWidth: true,
                  title: 'Update',
                  onAsyncTap: viewModel.onSaveTapped,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
