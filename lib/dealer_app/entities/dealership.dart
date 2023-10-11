import 'autonomy_level.dart';

/// Represents a Dealership
///
///
/// with [id], [cnpj], [name], [autonomyLevelId], [password]
/// and [isActive] properties.
class Dealership {
  /// Single unique indentification to each instance of dealership.
  final int? id;

  /// A brazilian document number each business has.
  final int cnpj;

  /// Name of a dealership instance.
  final String name;

  /// References the [AutonomyLevel] an instance of dealership belongs to.
  final int autonomyLevelId;

  /// The password of a dealership instance.
  final String password;

  /// Defines if a dealership is still active or not in the system.
  final bool isActive;

  /// Constructs an instance of an [Dealership]
  ///
  /// given the provided [id], [cnpj], [name],
  /// [autonomyLevelId], [password] and [isActive] properties.
  Dealership({
    this.id,
    required this.cnpj,
    required this.name,
    required this.autonomyLevelId,
    required this.password,
    required this.isActive,
  });

  @override
  String toString() {
    return name;
  }
}
