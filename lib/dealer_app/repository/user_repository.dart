import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../entities/user.dart';

// This method searches for the database's path and opens it
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'users.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(UsersTable.createTable);
    },
    version: 1,
  );
}

// This is the database constructor
class UsersTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $username     TEXT NOT NULL,
      $password     TEXT NOT NULL,
      $fullName     TEXT NOT NULL,
      $dealershipId INTEGER NOT NULL,
      $roleId       INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'user';
  static const String id = 'id';
  static const String username = 'username';
  static const String password = 'password';
  static const String fullName = 'fullName';
  static const String dealershipId = 'dealershipId';
  static const String roleId = 'roleId';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(User user) {
    final map = <String, dynamic>{};

    map[UsersTable.id] = user.id;
    map[UsersTable.username] = user.username;
    map[UsersTable.password] = user.password;
    map[UsersTable.fullName] = user.fullName;
    map[UsersTable.dealershipId] = user.dealershipId;
    map[UsersTable.roleId] = user.roleId;

    return map;
  }
}

// This controller is responsable for manipulating the database
class UserController {
  // Insert method serves for adding new items into the database
  Future<void> insert(User user) async {
    final database = await getDatabase();
    final map = UsersTable.toMap(user);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          UsersTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(User user) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          UsersTable.tableName,
          where: '${UsersTable.id} = ?',
          whereArgs: [user.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items registered on the database with the given dealership id
  Future<List<User>> select() async {
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
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(User user) async {
    final database = await getDatabase();

    final map = UsersTable.toMap(user);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          UsersTable.tableName,
          map,
          where: '${UsersTable.id} = ?',
          whereArgs: [user.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}
