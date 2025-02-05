import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms/src/viewmodel/cms_details_viewmodel.dart';

class CmsDetailsScreen<T, E> extends StatelessWidget {
  final CmsNavigator? cmsNavigator;
  final CmsConfig<T, E>? config;
  final T item;
  final Widget Function(
      BuildContext context, CmsDetailsViewModel<T, E> viewModel)? builder;
  final CmsDetailsViewModel<T, E>? viewModel;

  const CmsDetailsScreen({
    required this.cmsNavigator,
    required this.config,
    required this.item,
    this.builder,
    super.key,
  }) : viewModel = null;

  const CmsDetailsScreen.value({
    required CmsDetailsViewModel<T, E> this.viewModel,
    required this.item,
    this.builder,
    super.key,
  })  : cmsNavigator = null,
        config = null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CmsDetailsViewModel<T, E>>(
      create: (context) {
        if (viewModel != null) return viewModel!;
        return CmsDetailsViewModel(cmsNavigator!)
          ..initCms(context, config!, item);
      },
      child: Consumer<CmsDetailsViewModel<T, E>>(
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
                  itemBuilder: (context, field, index) =>
                      field.buildRead(context),
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
                  type: ImpaktfullUiButtonType.destructiveSecondary,
                  fullWidth: true,
                  title: 'Delete',
                  onAsyncTap: viewModel.onDeleteTapped,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
