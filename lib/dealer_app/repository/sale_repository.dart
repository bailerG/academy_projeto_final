import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/sale.dart';

// This method searches for the database's path and opens it
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'sales.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(SalesTable.createTable);
    },
    version: 1,
  );
}

// This is the database constructor
class SalesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerCpf    INTEGER NOT NULL,
      $customerName   TEXT NOT NULL,
      $soldWhen       TEXT NOT NULL,
      $priceSold      REAL NOT NULL,
      $dealershipCut  REAL NOT NULL,
      $businessCut    REAL NOT NULL,
      $safetyCut      REAL NOT NULL,
      $vehicleId      INTERGER NOT NULL,
      $dealershipId   INTEGER NOT NULL,
      $userId         INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'sale';
  static const String id = 'id';
  static const String customerCpf = 'customerCpf';
  static const String customerName = 'customerName';
  static const String soldWhen = 'soldWhen';
  static const String priceSold = 'priceSold';
  static const String dealershipCut = 'dealershipCut';
  static const String businessCut = 'businessCut';
  static const String safetyCut = 'safetyCut';
  static const String vehicleId = 'vehicleId';
  static const String dealershipId = 'dealershipId';
  static const String userId = 'userId';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[SalesTable.id] = sale.id;
    map[SalesTable.customerCpf] = sale.customerCpf;
    map[SalesTable.customerName] = sale.customerName;
    map[SalesTable.soldWhen] = sale.soldWhen;
    map[SalesTable.priceSold] = sale.priceSold;
    map[SalesTable.dealershipCut] = sale.dealershipCut;
    map[SalesTable.businessCut] = sale.businessCut;
    map[SalesTable.safetyCut] = sale.safetyCut;
    map[SalesTable.vehicleId] = sale.vehicleId;
    map[SalesTable.dealershipId] = sale.dealershipId;
    map[SalesTable.userId] = sale.userId;

    return map;
  }
}

// This controller is responsable for manipulating the database
class SaleController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          SalesTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(Sale sale) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          SalesTable.tableName,
          where: '${SalesTable.id} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items
  // registered on the database with the given dealership id
  Future<List<Sale>> selectByDealership(int dealershipId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.dealershipId} = ?',
      whereArgs: [dealershipId],
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipCut: item[SalesTable.dealershipCut],
          businessCut: item[SalesTable.businessCut],
          safetyCut: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          dealershipId: item[SalesTable.dealershipId],
          userId: item[SalesTable.userId],
        ),
      );
    }
    return list;
  }

// Select method returns a list of the items
// registered on the database with the given vehicle id
  Future<List<Sale>> selectByVehicle(int vehicleId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.vehicleId} = ?',
      whereArgs: [vehicleId],
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipCut: item[SalesTable.dealershipCut],
          businessCut: item[SalesTable.businessCut],
          safetyCut: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          dealershipId: item[SalesTable.dealershipId],
          userId: item[SalesTable.userId],
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(Sale sale) async {
    final database = await getDatabase();

    final map = SalesTable.toMap(sale);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          SalesTable.tableName,
          map,
          where: '${SalesTable.tableName} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}
