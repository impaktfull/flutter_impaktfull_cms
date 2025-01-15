import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/cms_updater.dart';

class CmsAddScreen<T, E> extends StatelessWidget {
  final CmsNavigator cmsNavigator;
  final CmsConfig<T, E> config;
  final Widget Function(BuildContext context, CmsAddViewModel<T, E> viewModel)?
      builder;

  const CmsAddScreen({
    required this.cmsNavigator,
    required this.config,
    this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CmsAddViewModel<T, E>>(
      create: (context) => CmsAddViewModel(cmsNavigator)..initCms(config),
      child: Consumer<CmsAddViewModel<T, E>>(
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
                  title: 'Save',
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
