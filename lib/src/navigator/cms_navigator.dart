import 'package:impaktfull_cms/impaktfull_cms.dart';

abstract class CmsNavigator {
  Future<T?> showAdd<T, E>(CmsConfig<T, E> config);

  Future<T?> showEdit<T, E>(CmsConfig<T, E> config, T item);

  Future<T?> showDetails<T, E>(CmsConfig<T, E> config, T item);

  Future<bool?> showDeleteConfirmation<T, E>(CmsConfig<T, E> config, T item);

  void showError({
    required String message,
    required Object error,
    required StackTrace trace,
  });

  void goBack();

  void goBackWithResult<T>({
    required T result,
  });
}
