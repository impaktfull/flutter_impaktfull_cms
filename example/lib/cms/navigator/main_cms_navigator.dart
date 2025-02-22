import 'package:flutter/material.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/data/user.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

class MainCmsNavigator extends CmsNavigator {
  final NavigatorState navigator;

  BuildContext get context => navigator.context;

  MainCmsNavigator({
    required this.navigator,
  });

  @override
  void goBack() => navigator.pop();

  @override
  void goBackWithResult<T>({required T result}) => navigator.pop(result);

  @override
  Future<T?> showAdd<T, E>(CmsConfig<T, E> config) => showDialog<T>(
        context: context,
        builder: (context) => ImpaktfullUiModal(
          childPadding: EdgeInsets.zero,
          title: 'Add new',
          showDividers: true,
          child: Builder(builder: (context) {
            if (T == User) {
              return CmsAddScreen(
                cmsNavigator: this,
                config: config,
              );
            } else {
              throw ArgumentError('Invalid type: $T');
            }
          }),
        ),
      );

  @override
  Future<T?> showDetails<T, E>(CmsConfig<T, E> config, T item) => showDialog<T>(
        context: context,
        builder: (context) => ImpaktfullUiModal(
          childPadding: EdgeInsets.zero,
          title: 'Details',
          showDividers: true,
          child: Builder(
            builder: (context) {
              if (T == User) {
                return CmsDetailsScreen(
                  cmsNavigator: this,
                  config: config,
                  item: item,
                );
              } else {
                throw ArgumentError('Invalid type: $T');
              }
            },
          ),
        ),
      );

  @override
  Future<T?> showEdit<T, E>(CmsConfig<T, E> config, T item) => showDialog<T>(
        context: context,
        builder: (context) => ImpaktfullUiModal(
          childPadding: EdgeInsets.zero,
          title: 'Edit',
          showDividers: true,
          child: Builder(builder: (context) {
            if (T == User) {
              return CmsEditScreen(
                cmsNavigator: this,
                config: config,
                item: item,
              );
            } else {
              throw ArgumentError('Invalid type: $T');
            }
          }),
        ),
      );

  @override
  Future<bool?> showDeleteConfirmation<T, E>(CmsConfig<T, E> config, T item) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ImpaktfullUiModal(
        title: 'Delete',
        showDividers: true,
        actions: [
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.secondaryGrey,
            title: 'Cancel',
            onTap: () => Navigator.of(context).pop(false),
          ),
          ImpaktfullUiButton(
            type: ImpaktfullUiButtonType.destructiveSecondary,
            title: 'Delete',
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
        child: Text(
          'Are you sure you want to delete this item?',
          style: ImpaktfullUiTheme.of(context).textStyles.onCanvas.text.small,
        ),
      ),
    );
  }

  @override
  void showError({
    required String message,
    required Object error,
    required StackTrace trace,
  }) {
    debugPrint(error.toString());
    debugPrint(trace.toString());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error.toString())),
    );
  }

  @override
  void showMissingFieldsError(List<CmsField> missingFields) {
    final keys = missingFields.map((e) => e.label).join(', ');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please fill in all required fields\b$keys')),
    );
  }
}
