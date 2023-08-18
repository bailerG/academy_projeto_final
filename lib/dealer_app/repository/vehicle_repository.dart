import 'package:desafio_academy_flutter/dealer_app/entities/vehicle.dart';
import 'package:desafio_academy_flutter/dealer_app/repository/sale_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'vehicles.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(VehiclesTable.createTable);
    },
    version: 1,
  );
}

class VehiclesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $plate TEXT PRIMARY KEY NOT NULL,
      $model TEXT NOT NULL,
      $brand TEXT NOT NULL,
      $builtYear INTEGER NOT NULL,
      $modelYear INTEGER NOT NULL,
      $photo TEXT NOT NULL,
      $pricePaid REAL NOT NULL,
      $purchasedWhen TEXT NOT NULL
    );
  ''';

  static const tableName = 'vehicle';
  static const plate = 'plate';
  static const model = 'model';
  static const brand = 'brand';
  static const builtYear = 'builtYear';
  static const modelYear = 'modelYear';
  static const photo = 'photo';
  static const pricePaid = 'pricePaid';
  static const purchasedWhen = 'purchasedWhen';

  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehiclesTable.plate] = vehicle.plate;
    map[VehiclesTable.model] = vehicle.model;
    map[VehiclesTable.brand] = vehicle.brand;
    map[VehiclesTable.builtYear] = vehicle.builtYear;
    map[VehiclesTable.modelYear] = vehicle.modelYear;
    map[VehiclesTable.photo] = vehicle.photo;
    map[VehiclesTable.pricePaid] = vehicle.pricePaid;
    map[VehiclesTable.purchasedWhen] = vehicle.purchasedWhen;

    return map;
  }
}

class VehicleController {
  Future<void> insert(Vehicle vehicle) async {
    final database = await getDatabase();
    final map = VehiclesTable.toMap(vehicle);

    await database.insert(VehiclesTable.tableName, map);

    return;
  }

  Future<List<Vehicle>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
    );

    var list = <Vehicle>[];

    for (final item in result) {
      list.add(
        Vehicle(
          model: item[VehiclesTable.model],
          brand: item[VehiclesTable.brand],
          builtYear: item[VehiclesTable.builtYear],
          plate: item[VehiclesTable.plate],
          modelYear: item[VehiclesTable.modelYear],
          photo: item[VehiclesTable.photo],
          pricePaid: item[VehiclesTable.pricePaid],
          purchasedWhen: item[VehiclesTable.purchasedWhen],
        ),
      );
    }
    return list;
  }
}
