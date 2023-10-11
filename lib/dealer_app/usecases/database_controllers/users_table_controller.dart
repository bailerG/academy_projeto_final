// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/user.dart';
import '../../repository/database/database.dart';
import '../../repository/database/users_table.dart';

/// The controller for [UsersTable]
///
///
/// It contains all the methods used to manipulate table's data.
class UsersTableController {
  /// Inserts the given [user] into database.
  Future<void> insert(User user) async {
    final database = await getDatabase();
    final map = UsersTable.toMap(user);

    await database.insert(
      UsersTable.tableName,
      map,
    );

    return;
  }

  /// Deletes a given [user] from database.
  Future<void> delete(User user) async {
    final database = await getDatabase();

    await database.delete(
      UsersTable.tableName,
      where: '${UsersTable.id} = ?',
      whereArgs: [user.id],
    );

    return;
  }

  /// Returns all instances of [User] saved on database as a list.
  Future<List<User>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      UsersTable.tableName,
    );

    var list = <User>[];

    for (final item in result) {
      list.add(
        User(
          id: item[UsersTable.id],
          username: item[UsersTable.username],
          password: item[UsersTable.password],
          fullName: item[UsersTable.fullName],
          dealershipId: item[UsersTable.dealershipId],
          roleId: item[UsersTable.roleId],
          isActive: item[UsersTable.isActive] == 1 ? true : false,
        ),
      );
    }
    return list;
  }

  /// Returns a single [User] from database given its [username].
  Future<User> selectByUsername(String username) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      UsersTable.tableName,
      where: '${UsersTable.username} = ?',
      whereArgs: [username],
    );

    final User user;

    if (result.length == 1) {
      user = User(
        id: result.first[UsersTable.id],
        username: result.first[UsersTable.username],
        password: result.first[UsersTable.password],
        fullName: result.first[UsersTable.fullName],
        dealershipId: result.first[UsersTable.dealershipId],
        roleId: result.first[UsersTable.roleId],
        isActive: result.first[UsersTable.isActive] == 1 ? true : false,
      );
    } else {
      throw Exception('More than one user with same username');
    }
    return user;
  }

  /// Updates the given [user] data contained in the database
  Future<void> update(User user) async {
    final database = await getDatabase();

    final map = UsersTable.toMap(user);

    await database.update(
      UsersTable.tableName,
      map,
      where: '${UsersTable.id} = ?',
      whereArgs: [user.id],
    );

    return;
  }
}
