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

// This is the Dealership database constructor
class DealershipsTable {
  static const String createTable = ''' 
    CREATE TABLE $tableName(
      $cnpj           INTEGER PRIMARY KEY NOT NULL,
      $name           TEXT NOT NULL,
      $autonomyLevel  TEXT NOT NULL,
      $password       TEXT NOT NULL
    );
  ''';

  static const String tableName = 'dealership';
  static const String cnpj = 'cnpj';
  static const String name = 'name';
  static const String autonomyLevel = 'autonomyLevel';
  static const String password = 'password';

  // This method transforms a given dealership object into a map instance
  static Map<String, dynamic> toMap(Dealership dealership) {
    final map = <String, dynamic>{};

    map[DealershipsTable.cnpj] = dealership.cnpj;
    map[DealershipsTable.name] = dealership.name;
    map[DealershipsTable.autonomyLevel] = dealership.autonomyLevel;
    map[DealershipsTable.password] = dealership.password;

    return map;
  }
}

// This controller is responsable for manipulating the database
class DealershipController {
  // Insert method serves for adding new dealerships into database
  Future<void> insert(Dealership dealership) async {
    final database = await getDatabase();
    final map = DealershipsTable.toMap(dealership);

    await database.insert(DealershipsTable.tableName, map);

    return;
  }

  // Select method returns a list of all the Dealerships registered on the database
  Future<List<Dealership>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      DealershipsTable.tableName,
    );

    var list = <Dealership>[];

    for (final item in result) {
      list.add(
        Dealership(
          cnpj: item[DealershipsTable.cnpj],
          name: item[DealershipsTable.name],
          autonomyLevel: item[DealershipsTable.autonomyLevel],
          password: item[DealershipsTable.password],
        ),
      );
    }
    return list;
  }
}
