import 'package:flutter/material.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/cms/config/user/user_cms_config.dart';
import 'package:impaktfull_cms_example/cms/navigator/main_cms_navigator.dart';
import 'package:impaktfull_cms_example/cms/repo/user/cms_user_repo.dart';

class ListWithoutViewmodelScreen extends StatelessWidget {
  const ListWithoutViewmodelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cmsNavigator = MainCmsNavigator(
      navigator: Navigator.of(context),
    );
    final repo = CmsUserRepo();
    return CmsListScreen(
      onBackTapped: () => cmsNavigator.goBack(),
      cmsNavigator: cmsNavigator,
      config: UserCmsConfig(
        cmsNavigator: cmsNavigator,
        repo: repo,
      ),
    );
  }
}
