import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/cms_updater.dart';

class CmsAddScreen<T, E> extends StatelessWidget {
  final CmsNavigator? cmsNavigator;
  final CmsConfig<T, E>? config;
  final Widget Function(BuildContext context, CmsAddViewModel<T, E> viewModel)?
      builder;
  final CmsAddViewModel<T, E>? viewModel;

  const CmsAddScreen({
    required this.cmsNavigator,
    required this.config,
    this.builder,
    super.key,
  }) : viewModel = null;

  const CmsAddScreen.value({
    required CmsAddViewModel<T, E> this.viewModel,
    this.builder,
    super.key,
  })  : cmsNavigator = null,
        config = null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CmsAddViewModel<T, E>>(
      create: (context) {
        if (viewModel != null) return viewModel!;
        return CmsAddViewModel(cmsNavigator!)..initCms(context, config!);
      },
      child: Consumer<CmsAddViewModel<T, E>>(
        builder: (context, viewModel, child) {
          if (builder != null) {
            return builder!(context, viewModel);
          }
          return ImpaktfullUiAutoLayout.vertical(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ImpaktfullUiListView.builder(
                  items: viewModel.fields,
                  padding: const EdgeInsets.all(16),
                  spacing: 8,
                  shrinkWrap: true,
                  itemBuilder: (context, field, index) => CmsFieldUpdater(
                    field: field,
                  ),
                  placeholderData: const ImpaktfullUiListViewPlaceholderData(
                    title: 'No fields',
                  ),
                ),
              ),
              const ImpaktfullUiDivider(),
              Padding(
                padding: const EdgeInsets.all(16),
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
