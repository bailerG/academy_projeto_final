import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/autonomy_level.dart';

// This method searches for the database's path and opens it
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'autonomy_level.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(AutonomyLevelsTable.createTable);
    },
    version: 1,
  );
}

// This is the database constructor
class AutonomyLevelsTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $name TEXT NOT NULL,
      $dealershipPercentage REAL NOT NULL,
      $safetyPercentage REAL NOT NULL,
      $headquartersPercentage REAL NOT NULL
    );
  ''';

  static const String tableName = 'Autonomy_level';
  static const String id = 'id';
  static const String name = 'name';
  static const String dealershipPercentage = 'dealership_percentage';
  static const String safetyPercentage = 'safety_percentage';
  static const String headquartersPercentage = 'headquarters_percentage';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(AutonomyLevel autonomyLevel) {
    final map = <String, dynamic>{};

    map[AutonomyLevelsTable.id] = autonomyLevel.id;
    map[AutonomyLevelsTable.name] = autonomyLevel.name;
    map[AutonomyLevelsTable.dealershipPercentage] =
        autonomyLevel.dealershipPercentage;
    map[AutonomyLevelsTable.safetyPercentage] = autonomyLevel.safetyPercentage;
    map[AutonomyLevelsTable.headquartersPercentage] =
        autonomyLevel.headquartersPercentage;

    return map;
  }
}

// This controller is responsable for manipulating the database
class AutonomyLevelsController {
  // Insert method serves for adding new items into the database
  Future<void> insert(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();
    final map = AutonomyLevelsTable.toMap(autonomyLevel);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          AutonomyLevelsTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          AutonomyLevelsTable.tableName,
          where: '${AutonomyLevelsTable.id} = ?',
          whereArgs: [autonomyLevel.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of all the items registered on the database
  Future<List<AutonomyLevel>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      AutonomyLevelsTable.tableName,
    );

    var list = <AutonomyLevel>[];

    for (final item in result) {
      list.add(
        AutonomyLevel(
          id: item[AutonomyLevelsTable.id],
          name: item[AutonomyLevelsTable.name],
          dealershipPercentage: item[AutonomyLevelsTable.dealershipPercentage],
          safetyPercentage: item[AutonomyLevelsTable.safetyPercentage],
          headquartersPercentage:
              item[AutonomyLevelsTable.headquartersPercentage],
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();

    final map = AutonomyLevelsTable.toMap(autonomyLevel);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          AutonomyLevelsTable.tableName,
          map,
          where: '${AutonomyLevelsTable.id} = ?',
          whereArgs: [autonomyLevel.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}
