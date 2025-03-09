import 'package:impaktfull_cms_example/data/user_role.dart';

class User {
  final int id;
  final double points;
  final String name;
  final String email;
  final String phoneNumber;
  final bool active;
  final String iconData;
  final UserRole role;
  final String? profilePictureUrl;

  const User({
    required this.id,
    required this.points,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.active,
    required this.iconData,
    required this.role,
    required this.profilePictureUrl,
  });

  User copyWith({
    int? id,
    double? points,
    String? name,
    String? email,
    String? phoneNumber,
    bool? active,
    String? iconData,
    UserRole? role,
    String? profilePictureUrl,
  }) {
    return User(
      id: id ?? this.id,
      points: points ?? this.points,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      active: active ?? this.active,
      iconData: iconData ?? this.iconData,
      role: role ?? this.role,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }
}
