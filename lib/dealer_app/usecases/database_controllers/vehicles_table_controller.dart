// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

import '../../entities/vehicle.dart';
import '../../repository/database/database.dart';
import '../../repository/database/vehicles_table.dart';

/// The controller for [VehiclesTable]
///
///
/// It contains all the methods used to manipulate table's data.
class VehiclesTableController {
  /// Inserts the given [vehicle] into database.
  Future<void> insert(Vehicle vehicle) async {
    final database = await getDatabase();
    final map = VehiclesTable.toMap(vehicle);

    await database.insert(
      VehiclesTable.tableName,
      map,
    );

    return;
  }

  /// Deletes a given [vehicle] from database.
  Future<void> delete(Vehicle vehicle) async {
    final database = await getDatabase();

    await database.delete(
      VehiclesTable.tableName,
      where: '${VehiclesTable.id} = ?',
      whereArgs: [vehicle.id],
    );

    return;
  }

  /// Returns all instances of [Vehicle] from a given [dealershipId] as a list.
  Future<List<Vehicle>> selectByDealership(int dealershipId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      VehiclesTable.tableName,
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
          photos: (item[VehiclesTable.photos]).toString(),
          pricePaid: item[VehiclesTable.pricePaid],
          purchasedDate:
              DateFormat('dd/MM/yyyy').parse(item[VehiclesTable.purchasedDate]),
          dealershipId: item[VehiclesTable.dealershipId],
          isSold: item[VehiclesTable.isSold] == 1 ? true : false,
        ),
      );
    }
    return list;
  }

  /// Returns a single [Vehicle] from database given its [id].
  Future<Vehicle> selectSingleVehicle(int id) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      VehiclesTable.tableName,
      where: '${VehiclesTable.id} = ?',
      whereArgs: [id],
    );

    final Vehicle vehicle;

    if (result.length == 1) {
      vehicle = Vehicle(
        id: result.first[VehiclesTable.id],
        model: result.first[VehiclesTable.model],
        brand: result.first[VehiclesTable.brand],
        builtYear: result.first[VehiclesTable.builtYear],
        plate: result.first[VehiclesTable.plate],
        modelYear: result.first[VehiclesTable.modelYear],
        photos: (result.first[VehiclesTable.photos]).toString(),
        pricePaid: result.first[VehiclesTable.pricePaid],
        purchasedDate: DateFormat('dd/MM/yyyy')
            .parse(result.first[VehiclesTable.purchasedDate]),
        dealershipId: result.first[VehiclesTable.dealershipId],
        isSold: result.first[VehiclesTable.isSold] == 1 ? true : false,
      );
    } else {
      throw Exception('More than one vehicle with same id');
    }
    return vehicle;
  }

  /// Updates the given [vehicle] data contained in the database
  Future<void> update(Vehicle vehicle) async {
    final database = await getDatabase();

    final map = VehiclesTable.toMap(vehicle);

    await database.update(
      VehiclesTable.tableName,
      map,
      where: '${VehiclesTable.id} = ?',
      whereArgs: [vehicle.id],
    );

    return;
  }
}
