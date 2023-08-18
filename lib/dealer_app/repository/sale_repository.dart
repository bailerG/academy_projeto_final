import 'package:desafio_academy_flutter/dealer_app/entities/sale.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
      $safetyCut      REAL NOT NULL
    );
  ''';

  static const tableName = 'sale';
  static const id = 'id';
  static const customerCpf = 'customerCpf';
  static const customerName = 'customerName';
  static const soldWhen = 'soldWhen';
  static const priceSold = 'priceSold';
  static const dealershipCut = 'dealershipCut';
  static const businessCut = 'businessCut';
  static const safetyCut = 'safetyCut';

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

    return map;
  }
}

class SaleController {
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    await database.insert(SalesTable.tableName, map);

    return;
  }

  Future<List<Sale>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
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
        ),
      );
    }
    return list;
  }
}
