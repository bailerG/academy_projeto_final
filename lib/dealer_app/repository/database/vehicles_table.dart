// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

import '../../entities/vehicle.dart';

/// The database table for [Vehicle]
///
///
/// It stores all variables such as [Vehicle.id],[Vehicle.model],
/// [Vehicle.plate], [Vehicle.brand], [Vehicle.builtYear],
/// [Vehicle.modelYear],[Vehicle.photos], [Vehicle.pricePaid],
/// [Vehicle.purchasedDate], [Vehicle.dealershipId],
/// [Vehicle.isSold] inside a .db file.
class VehiclesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $model          TEXT NOT NULL,
      $plate          TEXT NOT NULL,
      $brand          TEXT NOT NULL,
      $builtYear      INTEGER NOT NULL,
      $modelYear      INTEGER NOT NULL,
      $photos          TEXT NOT NULL,
      $pricePaid      REAL NOT NULL,
      $purchasedDate  TEXT NOT NULL,
      $dealershipId   INTEGER NOT NULL,
      $isSold         INTEGER NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'vehicle';

  /// [Vehicle.id] column name reference.
  static const String id = 'id';

  /// [Vehicle.model] column name reference.
  static const String model = 'model';

  /// [Vehicle.plate] column name reference.
  static const String plate = 'plate';

  /// [Vehicle.brand] column name reference.
  static const String brand = 'brand';

  /// [Vehicle.builtYear] column name reference.
  static const String builtYear = 'built_year';

  /// [Vehicle.modelYear] column name reference.
  static const String modelYear = 'model_year';

  /// [Vehicle.photos] column name reference.
  static const String photos = 'photo';

  /// [Vehicle.pricePaid] column name reference.
  static const String pricePaid = 'price_paid';

  /// [Vehicle.purchasedDate] column name reference.
  static const String purchasedDate = 'purchased_when';

  /// [Vehicle.dealershipId] column name reference.
  static const String dealershipId = 'dealership_id';

  /// [Vehicle.isSold] column name reference.
  static const String isSold = 'is_sold';

  /// Transforms a given [vehicle] into a map
  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehiclesTable.id] = vehicle.id;
    map[VehiclesTable.model] = vehicle.model;
    map[VehiclesTable.plate] = vehicle.plate;
    map[VehiclesTable.brand] = vehicle.brand;
    map[VehiclesTable.builtYear] = vehicle.builtYear;
    map[VehiclesTable.modelYear] = vehicle.modelYear;
    map[VehiclesTable.photos] = vehicle.photos;
    map[VehiclesTable.pricePaid] = vehicle.pricePaid.toStringAsFixed(2);
    map[VehiclesTable.purchasedDate] =
        DateFormat('dd/MM/yyyy').format(vehicle.purchasedDate);
    map[VehiclesTable.dealershipId] = vehicle.dealershipId;
    map[VehiclesTable.isSold] = vehicle.isSold ? 1 : 0;

    return map;
  }
}
