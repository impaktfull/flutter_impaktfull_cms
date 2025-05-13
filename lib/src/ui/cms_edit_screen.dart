import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/ui/cms_updater.dart';
import 'package:impaktfull_cms/src/viewmodel/cms_edit_viewmodel.dart';

class CmsEditScreen<T, E> extends StatelessWidget {
  final CmsNavigator? cmsNavigator;
  final CmsConfig<T, E>? config;
  final T item;
  final Widget Function(BuildContext context, CmsEditViewModel<T, E> viewModel)?
      builder;
  final CmsEditViewModel<T, E>? viewModel;

  const CmsEditScreen({
    required this.cmsNavigator,
    required this.config,
    required this.item,
    this.builder,
    super.key,
  }) : viewModel = null;

  const CmsEditScreen.value({
    required CmsEditViewModel<T, E> this.viewModel,
    required this.item,
    this.builder,
    super.key,
  })  : cmsNavigator = null,
        config = null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CmsEditViewModel<T, E>>(
      create: (context) {
        if (viewModel != null) return viewModel!;
        return CmsEditViewModel(cmsNavigator!)..initCms(context, config!, item);
      },
      child: Consumer<CmsEditViewModel<T, E>>(
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
                child: ImpaktfullUiAutoLayout.vertical(
                  children: [
                    if (viewModel.isDeletable) ...[
                      ImpaktfullUiButton(
                        type: ImpaktfullUiButtonType.destructiveTertiary,
                        fullWidth: true,
                        title: 'Delete',
                        onAsyncTap: viewModel.onDeleteTapped,
                      ),
                    ],
                    ImpaktfullUiButton(
                      type: ImpaktfullUiButtonType.secondary,
                      fullWidth: true,
                      title: 'Update',
                      onAsyncTap: viewModel.onSaveTapped,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
