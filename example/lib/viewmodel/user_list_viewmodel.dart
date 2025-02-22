import 'package:flutter/material.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/cms/config/user/user_cms_config.dart';
import 'package:impaktfull_cms_example/cms/repo/user/cms_user_repo.dart';
import 'package:impaktfull_cms_example/data/user.dart';

class UserListViewmodel extends CmsListViewModel<User, int> {
  final CmsUserRepo repo;

  UserListViewmodel(
    this.repo,
    super.cmsNavigator,
  );

  Future<void> init(BuildContext context) async {
    final config = UserCmsConfig(
      cmsNavigator: cmsNavigator,
      repo: repo,
    );
    await initCms(context, config);
  }
}
