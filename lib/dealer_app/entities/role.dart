/// Represents a Role
/// with [id] and [roleName] properties.
class Role {
  /// Single unique indentification to each instance of role.
  final int? id;

  /// Name of a role instance.
  final String roleName;

  /// Constructs an instance of [Role]
  ///
  /// given the provided [id] and [roleName] properties.
  Role({
    this.id,
    required this.roleName,
  });

  @override
  String toString() {
    return roleName;
  }
}
