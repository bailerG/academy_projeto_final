class User {
  final int? id;
  final String username;
  final String password;
  final String fullName;
  final int dealershipId;
  final int roleId;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.fullName,
    required this.dealershipId,
    required this.roleId,
  });

  @override
  String toString() {
    return fullName;
  }
}
