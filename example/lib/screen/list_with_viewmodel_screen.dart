import 'package:flutter/material.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/cms/navigator/main_cms_navigator.dart';
import 'package:impaktfull_cms_example/cms/repo/user/cms_user_repo.dart';
import 'package:impaktfull_cms_example/viewmodel/user_list_viewmodel.dart';

class ListWithViewmodelScreen extends StatelessWidget {
  const ListWithViewmodelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cmsNavigator = MainCmsNavigator(
      navigator: Navigator.of(context),
    );
    final repo = CmsUserRepo();
    return CmsListScreen.value(
      onBackTapped: () => cmsNavigator.goBack(),
      viewModel: UserListViewmodel(
        repo,
        cmsNavigator,
      )..init(context),
    );
  }
}
