import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:impaktfull_cms_example/data/user.dart';
import 'package:impaktfull_cms/impaktfull_cms.dart';
import 'package:impaktfull_cms_example/data/user_role.dart';
import 'package:impaktfull_cms_example/repo/user_repo.dart';
import 'package:impaktfull_ui/impaktfull_ui.dart';

enum _UserField {
  id,
  name,
  email,
  phoneNumber,
  active,
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
  });

  @override
  int getId(User item) => item.id;

  @override
  String getTitle() => 'Users';

  @override
  List<CmsHeader> getHeaders() => [
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
        CmsReferenceField<UserRole>(
          id: _UserField.role,
          label: 'User role',
          modalTitle: 'Select user role',
          noDataSelected: 'No user role selected',
          items: UserRole.values
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
  Future<PagingInfo<User>> loadItems({
    required int page,
    required int pageSize,
  }) async =>
      UserRepo.instance.getUsers(
        page: page,
        pageSize: pageSize,
      );

  @override
  Future<User> loadItem(int id) async => UserRepo.instance.getUser(id);

  @override
  Future<void> deleteItem(User item) async => UserRepo.instance.delete(item);

  @override
  Future<User> saveItem(User item) async => UserRepo.instance.save(item);

  @override
  Future<User> updateItem(int id, User item) async =>
      UserRepo.instance.update(item);

  @override
  Widget buildRow({
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
      name: fields.getStringField(_UserField.name).value ?? '',
      email: fields.getStringField(_UserField.email).value ?? '',
      phoneNumber: fields.getStringField(_UserField.phoneNumber).value ?? '',
      active: fields.getBoolField(_UserField.active).value ?? true,
      role:
          fields.getReferenceField(_UserField.role).value ?? UserRole.anonymous,
    );
  }

  @override
  User updateOldItem(User item, List<CmsField> fields) => item.copyWith(
        name: fields.getStringField(_UserField.name).value,
        email: fields.getStringField(_UserField.email).value,
        phoneNumber: fields.getStringField(_UserField.phoneNumber).value,
        active: fields.getBoolField(_UserField.active).value ?? true,
        role: fields.getReferenceField(_UserField.role).value ??
            UserRole.anonymous,
      );
}
