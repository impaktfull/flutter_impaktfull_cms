import 'package:flutter/widgets.dart';
import 'package:impaktfull_architecture/impaktfull_architecture.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';

class CmsListScreen<T, E> extends StatelessWidget {
  final CmsNavigator? cmsNavigator;
  final CmsConfig<T, E>? config;
  final bool isDrawerEnabled;
  final VoidCallback? onBackTapped;
  final List<ImpaktfullUiAdaptiveNavBarActionItem> actions;
  final Widget Function(
    BuildContext context,
    CmsListViewModel<T, E> viewModel,
  )? builder;
  final CmsListViewModel<T, E>? viewModel;

  const CmsListScreen({
    required CmsNavigator this.cmsNavigator,
    required CmsConfig<T, E> this.config,
    this.builder,
    this.isDrawerEnabled = false,
    this.onBackTapped,
    this.actions = const [],
    super.key,
  }) : viewModel = null;

  const CmsListScreen.value({
    required CmsListViewModel<T, E> this.viewModel,
    this.builder,
    this.isDrawerEnabled = false,
    this.onBackTapped,
    this.actions = const [],
    super.key,
  })  : cmsNavigator = null,
        config = null;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CmsListViewModel<T, E>>(
      create: (context) {
        if (viewModel != null) return viewModel!;
        return CmsListViewModel(cmsNavigator!)..initCms(context, config!);
      },
      child: Consumer<CmsListViewModel<T, E>>(
        builder: (context, viewModel, child) {
          if (builder != null) {
            return builder!(context, viewModel);
          }
          return ImpaktfullUiAdaptiveScreen(
            title: viewModel.title,
            subtitle: viewModel.subtitle,
            onBackTapped: onBackTapped,
            isDrawerEnabled: isDrawerEnabled,
            actions: [
              ...actions,
              if (viewModel.isAddNewEnabled) ...[
                ImpaktfullUiAdaptiveNavBarActionItem(
                  asset: ImpaktfullUiTheme.of(context).assets.icons.add,
                  title: 'Add',
                  onTap: viewModel.onAddTapped,
                ),
              ],
            ],
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(16),
              child: ImpaktfullUiAutoLayout.vertical(
                spacing: 8,
                children: [
                  Expanded(
                    child: ImpaktfullUiTable(
                      isLoading: viewModel.isLoading,
                      titles: viewModel.headers
                          .map(
                            (e) => ImpaktfullUiTableHeaderItem(
                              title: e.title,
                              ascending: viewModel.isSortAscending(e),
                              onTap: e.isSortable
                                  ? () => viewModel.onSortTapped(e)
                                  : null,
                            ),
                          )
                          .toList(),
                      content: viewModel.getRows(context).map(
                        (e) {
                          if (e is ImpaktfullUiTableRow) {
                            return e;
                          }
                          return ImpaktfullUiTableRow(
                            columns: [
                              ImpaktfullUiTableRowItem.custom(
                                builder: (context, theme) {
                                  return e;
                                },
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  ImpaktfullUiPagination(
                    page: viewModel.page,
                    itemsPerPage: viewModel.pageSize,
                    amountOfItems: viewModel.totalItems,
                    onLoadPage: viewModel.onLoadPage,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
