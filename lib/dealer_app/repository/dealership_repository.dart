import 'package:desafio_academy_flutter/dealer_app/entities/dealership.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// This method searches for the database's path and opens it
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'dealerships.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(DealershipsTable.createTable);
    },
    version: 1,
  );
}

// This is the database constructor
class DealershipsTable {
  static const String createTable = ''' 
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj           INTEGER NOT NULL,
      $name           TEXT NOT NULL,
      $autonomyLevel  TEXT NOT NULL,
      $password       TEXT NOT NULL
    );
  ''';

  static const String tableName = 'dealership';
  static const String id = 'id';
  static const String cnpj = 'cnpj';
  static const String name = 'name';
  static const String autonomyLevel = 'autonomyLevel';
  static const String password = 'password';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Dealership dealership) {
    final map = <String, dynamic>{};

    map[DealershipsTable.id] = dealership.id;
    map[DealershipsTable.cnpj] = dealership.cnpj;
    map[DealershipsTable.name] = dealership.name;
    map[DealershipsTable.autonomyLevel] = dealership.autonomyLevel;
    map[DealershipsTable.password] = dealership.password;

    return map;
  }
}

// This controller is responsable for manipulating the database
class DealershipController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Dealership dealership) async {
    final database = await getDatabase();
    final map = DealershipsTable.toMap(dealership);

    await database.insert(DealershipsTable.tableName, map);

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(Dealership dealership) async {
    final database = await getDatabase();

    database.delete(
      DealershipsTable.tableName,
      where: '${DealershipsTable.id} = ?',
      whereArgs: [dealership.id],
    );

    return;
  }

  // Select method returns a list of all the items registered on the database
  Future<List<Dealership>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      DealershipsTable.tableName,
    );

    var list = <Dealership>[];

    for (final item in result) {
      list.add(
        Dealership(
          id: item[DealershipsTable.id],
          cnpj: item[DealershipsTable.cnpj],
          name: item[DealershipsTable.name],
          autonomyLevel: item[DealershipsTable.autonomyLevel],
          password: item[DealershipsTable.password],
        ),
      );
    }
    return list;
  }

  // Update method
  Future<void> update(Dealership dealership) async {
    final database = await getDatabase();

    final map = DealershipsTable.toMap(dealership);

    await database.update(
      DealershipsTable.tableName,
      map,
      where: '${DealershipsTable.id} = ?',
      whereArgs: [dealership.id],
    );

    return;
  }
}
