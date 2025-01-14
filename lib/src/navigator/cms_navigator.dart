import 'package:impaktfull_cms/impaktfull_cms.dart';

abstract class CmsNavigator {
  void showError({
    required Object error,
    required StackTrace trace,
  });

  void goToCmsDetail<T, E>(CmsConfig<T, E> config, T item);

  Future<T?> showAdd<T, E>(CmsConfig<T, E> config);

  Future<T?> showEdit<T, E>(CmsConfig<T, E> config, T item);

  Future<T?> showDetails<T, E>(CmsConfig<T, E> config, T item);

  Future<bool?> showDeleteConfirmation<T, E>(CmsConfig<T, E> config, T item);

  void goBack();

  void goBackWithResult<T>({
    required T result,
  });
}
