import '../entities/vehicle.dart';
import '../repository/sale_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// This method searches for the database's path and opens it
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

// This is the database constructor
class VehiclesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $model          TEXT NOT NULL,
      $plate          TEXT NOT NULL,
      $brand          TEXT NOT NULL,
      $builtYear      INTEGER NOT NULL,
      $modelYear      INTEGER NOT NULL,
      $photo          TEXT NOT NULL,
      $pricePaid      REAL NOT NULL,
      $purchasedWhen  TEXT NOT NULL,
      $dealershipId   INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'vehicle';
  static const String id = 'id';
  static const String model = 'model';
  static const String plate = 'plate';
  static const String brand = 'brand';
  static const String builtYear = 'builtYear';
  static const String modelYear = 'modelYear';
  static const String photo = 'photo';
  static const String pricePaid = 'pricePaid';
  static const String purchasedWhen = 'purchasedWhen';
  static const String dealershipId = 'dealershipId';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehiclesTable.id] = vehicle.id;
    map[VehiclesTable.model] = vehicle.model;
    map[VehiclesTable.plate] = vehicle.plate;
    map[VehiclesTable.brand] = vehicle.brand;
    map[VehiclesTable.builtYear] = vehicle.builtYear;
    map[VehiclesTable.modelYear] = vehicle.modelYear;
    map[VehiclesTable.photo] = vehicle.photo;
    map[VehiclesTable.pricePaid] = vehicle.pricePaid;
    map[VehiclesTable.purchasedWhen] = vehicle.purchasedWhen;
    map[VehiclesTable.dealershipId] = vehicle.dealershipId;

    return map;
  }
}

// This controller is responsable for manipulating the database
class VehicleController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Vehicle vehicle) async {
    final database = await getDatabase();
    final map = VehiclesTable.toMap(vehicle);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          VehiclesTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(Vehicle vehicle) async {
    final database = await getDatabase();

    await database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          VehiclesTable.tableName,
          where: '${VehiclesTable.id} = ?',
          whereArgs: [vehicle.id],
        );

        batch.delete(
          SalesTable.tableName,
          where: '${SalesTable.vehicleId} = ?',
          whereArgs: [vehicle.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items registered on the database with the given dealership id
  Future<List<Vehicle>> select(int dealershipId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${VehiclesTable.dealershipId} = ?',
      whereArgs: [dealershipId],
    );

    var list = <Vehicle>[];

    for (final item in result) {
      list.add(
        Vehicle(
          id: item[VehiclesTable.id],
          model: item[VehiclesTable.model],
          brand: item[VehiclesTable.brand],
          builtYear: item[VehiclesTable.builtYear],
          plate: item[VehiclesTable.plate],
          modelYear: item[VehiclesTable.modelYear],
          photo: item[VehiclesTable.photo],
          pricePaid: item[VehiclesTable.pricePaid],
          purchasedWhen: item[VehiclesTable.purchasedWhen],
          dealershipId: item[VehiclesTable.dealershipId],
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(Vehicle vehicle) async {
    final database = await getDatabase();

    final map = VehiclesTable.toMap(vehicle);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          VehiclesTable.tableName,
          map,
          where: '${VehiclesTable.id} = ?',
          whereArgs: [vehicle.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}
