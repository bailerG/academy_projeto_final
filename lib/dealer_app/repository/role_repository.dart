import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/role.dart';
import '../repository/dealership_repository.dart';

// This method searches for the database's path and opens it
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'roles.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(RolesTable.createTable);
    },
    version: 1,
  );
}

// This is the database constructor
class RolesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $roleName   TEXT NOT NULL
    );
  ''';

  static const String tableName = 'role';
  static const String id = 'id';
  static const String roleName = 'roleName';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Role role) {
    final map = <String, dynamic>{};

    map[RolesTable.id] = role.id;
    map[RolesTable.roleName] = role.roleName;

    return map;
  }
}

// This controller is responsable for manipulating the database
class RoleController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Role role) async {
    final database = await getDatabase();
    final map = RolesTable.toMap(role);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          RolesTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(Role role) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          DealershipsTable.tableName,
          where: '${RolesTable.id} = ?',
          whereArgs: [role.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items registered on the database with
  //the given dealership id
  Future<List<Role>> select() async {
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

  // Update method updates the object on the database
  Future<void> update(Role role) async {
    final database = await getDatabase();

    final map = RolesTable.toMap(role);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          RolesTable.tableName,
          map,
          where: '${RolesTable.id} = ?',
          whereArgs: [role.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}
