import 'package:flutter/material.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/cms/config/user/user_cms_config.dart';
import 'package:impaktfull_cms_example/cms/navigator/main_cms_navigator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cmsNavigator = MainCmsNavigator(
      navigator: Navigator.of(context),
    );
    return CmsListScreen(
      cmsNavigator: cmsNavigator,
      config: UserCmsConfig(
        cmsNavigator: cmsNavigator,
      ),
    );
  }
}
