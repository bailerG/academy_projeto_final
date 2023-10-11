// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/role.dart';

/// The database table for [Role]
///
///
/// It stores all parameters such as [Role.id],
/// [Role.roleName], inside a .db file.
class RolesTable {
  /// This is a SQLite command for creating this table.
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $roleName   TEXT NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'role';

  /// [Role.id] column name reference.
  static const String id = 'id';

  /// [Role.roleName] column name reference.
  static const String roleName = 'role_name';

  /// Inserts the [Admin] role when database is created.
  static const adminRoleRawInsert =
      'INSERT INTO $tableName($roleName) VALUES("Admin")';

  /// Inserts the [Associado] role when database is created.
  static const associateRoleRawInsert =
      'INSERT INTO $tableName($roleName) VALUES("Associado")';

  /// Transforms a given [role] into a map.
  static Map<String, dynamic> toMap(Role role) {
    final map = <String, dynamic>{};

    map[RolesTable.id] = role.id;
    map[RolesTable.roleName] = role.roleName;

    return map;
  }
}
