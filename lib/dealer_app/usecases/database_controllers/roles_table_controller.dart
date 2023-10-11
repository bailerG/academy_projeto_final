// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/role.dart';
import '../../repository/database/database.dart';
import '../../repository/database/roles_table.dart';

/// The controller for [RolesTable]
///
///
/// It contains all the methods used to manipulate table's data.
class RolesTableController {
  /// Returns all instances of [Role] saved on database as a list.
  Future<List<Role>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      RolesTable.tableName,
    );

    var list = <Role>[];

    for (final item in result) {
      list.add(
        Role(
          id: item[RolesTable.id],
          roleName: item[RolesTable.roleName],
        ),
      );
    }
    return list;
  }
}
