// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/user.dart';

/// The database table for [User]
/// .
/// .
/// It stores all variables such as [User.id],[User.username],
/// [User.password],[User.fullName], [User.dealershipId],
/// [User.roleId], [User.isActive] inside a .db file.
class UsersTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $username     TEXT NOT NULL,
      $password     TEXT NOT NULL,
      $fullName     TEXT NOT NULL,
      $dealershipId INTEGER NOT NULL,
      $roleId       INTEGER NOT NULL,
      $isActive     INTEGER NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'user';

  /// [User.id] column name reference.
  static const String id = 'id';

  /// [User.username] column name reference.
  static const String username = 'username';

  /// [User.password] column name reference.
  static const String password = 'password';

  /// [User.fullName] column name reference.
  static const String fullName = 'full_name';

  /// [User.dealershipId] column name reference.
  static const String dealershipId = 'dealership_id';

  /// [User.roleId] column name reference.
  static const String roleId = 'role_id';

  /// [User.isActive] column name reference.
  static const String isActive = 'is_active';

  /// Inserts the admin user when database is created.
  static const adminUserRawInsert =
      'INSERT INTO $tableName($username,$password,$fullName,$dealershipId,'
      '$roleId,$isActive) VALUES("admin","admin","Anderson",1,1,1)';

  /// Transforms a given [user] into a map.
  static Map<String, dynamic> toMap(User user) {
    final map = <String, dynamic>{};

    map[UsersTable.id] = user.id;
    map[UsersTable.username] = user.username;
    map[UsersTable.password] = user.password;
    map[UsersTable.fullName] = user.fullName;
    map[UsersTable.dealershipId] = user.dealershipId;
    map[UsersTable.roleId] = user.roleId;
    map[UsersTable.isActive] = user.isActive ? 1 : 0;

    return map;
  }
}
