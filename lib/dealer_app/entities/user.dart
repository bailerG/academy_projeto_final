import 'dealership.dart';
import 'role.dart';

/// Represents a User
///
///
/// with [id], [username], [password], [fullName], [dealershipId],
/// [roleId] and [isActive] properties.
class User {
  /// Single unique indentification to each instance of user.
  final int? id;

  /// A nickname from an instance of user.
  final String username;

  /// The password used for loggin on an instance of user.
  final String password;

  /// The full name of a person who an instance of user belongs.
  final String fullName;

  /// The [Dealership.id] from the dealership an instance of user belongs.
  final int dealershipId;

  /// The [Role.id] attributed to an instance of user, defining its access
  /// to certain functionalities within the app.
  final int roleId;

  /// Defines if an instance of user is still active/allowed to be used or not
  final bool isActive;

  /// Constructs an instance of an [Sale]
  ///
  /// given the provided [id], [username], [password], [fullName],
  /// [dealershipId], [roleId] and [isActive] properties.
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
