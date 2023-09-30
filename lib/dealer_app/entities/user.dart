class User {
  final int? id;
  final String username;
  final String password;
  final String fullName;
  final int dealershipId;
  final int roleId;
  final bool isActive;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.fullName,
    required this.dealershipId,
    required this.roleId,
    required this.isActive,
  });

  @override
  String toString() {
    return fullName;
  }
}
