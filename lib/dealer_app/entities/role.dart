class Role {
  final int? id;
  final String roleName;

  Role({
    this.id,
    required this.roleName,
  });

  @override
  String toString() {
    return roleName;
  }
}
