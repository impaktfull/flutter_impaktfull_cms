import 'dart:async';

import 'package:flutter/material.dart';
import 'package:impaktfull_cms_example/data/icon_data.dart';
import 'package:impaktfull_cms_example/data/user.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/data/user_role.dart';
import 'package:impaktfull_cms_example/extension/list_extension.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

enum _UserField {
  id,
  name,
  email,
  phoneNumber,
  active,
  icon,
  profilePicture,
  role;
}

enum _UserHeader {
  name,
  email,
  phoneNumber;
}

class UserCmsConfig extends CmsConfig<User, int> {
  UserCmsConfig({
    required super.cmsNavigator,
    required super.repo,
  });

  @override
  int getId(User item) => item.id;

  @override
  String getTitle({
    required BuildContext context,
  }) =>
      'Users';

  @override
  List<CmsHeader> getHeaders({
    required BuildContext context,
  }) =>
      [
        const CmsHeader(
          id: _UserHeader.name,
          title: 'Name',
          isSortable: true,
        ),
        const CmsHeader(
          id: _UserHeader.email,
          title: 'Email',
          isSortable: true,
        ),
        const CmsHeader(
          id: _UserHeader.phoneNumber,
          title: 'Phone Number',
          isSortable: false,
        ),
      ];

  @override
  List<CmsField<dynamic>> getFields({
    required BuildContext context,
    User? item,
  }) =>
      [
        CmsIntField(
          id: _UserField.id,
          label: 'Index',
          initialValue: item?.id ?? 0,
          min: 0,
        ),
        CmsStringField(
          id: _UserField.name,
          label: 'Name',
          initialValue: item?.name,
        ),
        CmsStringField(
          id: _UserField.email,
          label: 'Email',
          initialValue: item?.email,
        ),
        CmsStringField(
          id: _UserField.phoneNumber,
          label: 'Phone Number',
          initialValue: item?.phoneNumber,
        ),
        CmsBoolField(
          id: _UserField.active,
          label: 'User enabled?',
          labelSelected: 'Enabled',
          labelUnselected: 'Disabled',
          initialValue: item?.active ?? true,
        ),
        CmsIconField<String>(
          id: _UserField.icon,
          label: 'User icon',
          modalTitle: 'Select user icon',
          noDataSelected: 'No user icon selected',
          items: () async => CmsIconData.list,
          initialValue: CmsIconData.list
              .firstOrNullWhere((e) => e.name == item?.iconData),
        ),
        CmsReferenceField<UserRole>(
          id: _UserField.role,
          label: 'User role',
          modalTitle: 'Select user role',
          noDataSelected: 'No user role selected',
          initialValue: item == null
              ? null
              : CmsReference(
                  value: item.role,
                  title: item.role.name,
                ),
          items: () async => UserRole.values
              .map(
                (e) => CmsReference(value: e, title: e.name),
              )
              .toList(),
          search: (search) async => UserRole.values
              .where((e) => e.name.contains(search))
              .map(
                (e) => CmsReference(value: e, title: e.name),
              )
              .toList(),
        ),
        CmsImageUrlField(
          id: _UserField.profilePicture,
          label: 'User profile picture',
          aspectRatio: 1,
          fit: BoxFit.cover,
        ),
      ];

  @override
  FutureOr<bool> isAddNewEnabled() => true;

  @override
  Widget buildRow({
    required BuildContext context,
    required User item,
    void Function()? onOpenTapped,
    void Function()? onEditTapped,
    void Function()? onDeleteTapped,
  }) {
    return ImpaktfullUiTableRow(
      columns: [
        ImpaktfullUiTableRowItem.text(
          title: item.name,
          onTap: onOpenTapped,
        ),
        ImpaktfullUiTableRowItem.text(title: item.email),
        ImpaktfullUiTableRowItem.text(title: item.phoneNumber),
      ],
    );
  }

  @override
  User createNewItem(List<CmsField> fields) {
    return User(
      id: 0,
      name: fields.getString(_UserField.name) ?? '',
      email: fields.getString(_UserField.email) ?? '',
      phoneNumber: fields.getString(_UserField.phoneNumber) ?? '',
      active: fields.getBool(_UserField.active) ?? true,
      iconData: fields.getIcon<String>(_UserField.icon)?.name ?? '',
      role: fields.getReference(_UserField.role) ?? UserRole.anonymous,
      profilePictureUrl: fields.getString(_UserField.profilePicture),
    );
  }

  @override
  User updateOldItem(User item, List<CmsField> fields) => item.copyWith(
        name: fields.getString(_UserField.name),
        email: fields.getString(_UserField.email),
        phoneNumber: fields.getString(_UserField.phoneNumber),
        active: fields.getBool(_UserField.active),
        iconData: fields.getIcon<String>(_UserField.icon)?.value,
        role: fields.getReference(_UserField.role),
        profilePictureUrl: fields.getString(_UserField.profilePicture),
      );
}
