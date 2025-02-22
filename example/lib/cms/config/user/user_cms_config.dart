import 'dart:async';

import 'package:flutter/material.dart';
import 'package:impaktfull_cms_example/data/user.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/data/user_role.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

enum _UserField {
  id,
  name,
  email,
  phoneNumber,
  active,
  icon,
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
          initialValue: true,
        ),
        CmsIconField(
          id: _UserField.icon,
          label: 'User icon',
          modalTitle: 'Select user icon',
          noDataSelected: 'No user icon selected',
          items: () async => [
            const CmsIcon(
              icon: ImpaktfullUiAsset.icon(Icons.arrow_back),
              name: 'Arrow back',
            ),
            const CmsIcon(
              icon: ImpaktfullUiAsset.icon(Icons.arrow_upward),
              name: 'Arrow upward',
            ),
            const CmsIcon(
              icon: ImpaktfullUiAsset.icon(Icons.arrow_downward),
              name: 'Arrow downward',
            ),
            const CmsIcon(
              icon: ImpaktfullUiAsset.icon(Icons.arrow_forward),
              name: 'Arrow forward',
            ),
            const CmsIcon(
              icon: ImpaktfullUiAsset.icon(Icons.chevron_right),
            ),
          ],
          initialValue: const CmsIcon(
            icon: ImpaktfullUiAsset.icon(Icons.arrow_forward),
            name: 'Person',
          ),
        ),
        CmsReferenceField<UserRole>(
          id: _UserField.role,
          label: 'User role',
          modalTitle: 'Select user role',
          noDataSelected: 'No user role selected',
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
      role: fields.getReference(_UserField.role) ?? UserRole.anonymous,
    );
  }

  @override
  User updateOldItem(User item, List<CmsField> fields) => item.copyWith(
        name: fields.getString(_UserField.name),
        email: fields.getString(_UserField.email),
        phoneNumber: fields.getString(_UserField.phoneNumber),
        active: fields.getBool(_UserField.active) ?? true,
        role: fields.getReference(_UserField.role) ?? UserRole.anonymous,
      );
}
