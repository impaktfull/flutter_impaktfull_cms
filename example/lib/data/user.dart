class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
