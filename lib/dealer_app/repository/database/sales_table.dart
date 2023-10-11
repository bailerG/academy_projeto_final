// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';

import '../../entities/sale.dart';

/// The database table for [Sale]
/// .
/// .
/// It stores all variables such as [Sale.id],[Sale.customerCpf],
/// [Sale.customerName], [Sale.soldWhen], [Sale.priceSold],
/// [Sale.dealershipPercentage],[Sale.headquartersPercentage],
/// [Sale.safetyPercentage], [Sale.vehicleId], [Sale.dealershipId],
/// [Sale.userId], [Sale.isComplete] inside a .db file.
class SalesTable {
  /// This is a SQLite command for creating this table.
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id                     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerCpf            INTEGER NOT NULL,
      $customerName           TEXT NOT NULL,
      $soldWhen               TEXT NOT NULL,
      $priceSold              REAL NOT NULL,
      $dealershipPercentage   REAL NOT NULL,
      $headquartersPercentage REAL NOT NULL,
      $safetyPercentage       REAL NOT NULL,
      $vehicleId              INTERGER NOT NULL,
      $dealershipId           INTEGER NOT NULL,
      $userId                 INTEGER NOT NULL,
      $isComplete             INTEGER NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'sale';

  /// [Sale.id] column name reference.
  static const String id = 'id';

  /// [Sale.customerCpf] column name reference.
  static const String customerCpf = 'customer_cpf';

  /// [Sale.customerName] column name reference.
  static const String customerName = 'customer_name';

  /// [Sale.soldWhen] column name reference.
  static const String soldWhen = 'sold_when';

  /// [Sale.priceSold] column name reference.
  static const String priceSold = 'price_sold';

  /// [Sale.dealershipPercentage] column name reference.
  static const String dealershipPercentage = 'dealership_cut';

  /// [Sale.headquartersPercentage] column name reference.
  static const String headquartersPercentage = 'business_cut';

  /// [Sale.safetyPercentage] column name reference.
  static const String safetyPercentage = 'safety_cut';

  /// [Sale.vehicleId] column name reference.
  static const String vehicleId = 'vehicle_id';

  /// [Sale.dealershipId] column name reference.
  static const String dealershipId = 'dealership_id';

  /// [Sale.userId] column name reference.
  static const String userId = 'user_id';

  /// [Sale.isComplete] column name reference.
  static const String isComplete = 'is_complete';

  /// Transforms a given [sale] into a map.
  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[SalesTable.id] = sale.id;
    map[SalesTable.customerCpf] = sale.customerCpf;
    map[SalesTable.customerName] = sale.customerName;
    map[SalesTable.soldWhen] = DateFormat('dd/MM/yyyy').format(sale.soldWhen);
    map[SalesTable.priceSold] = sale.priceSold;
    map[SalesTable.dealershipPercentage] = sale.dealershipPercentage;
    map[SalesTable.headquartersPercentage] = sale.headquartersPercentage;
    map[SalesTable.safetyPercentage] = sale.safetyPercentage;
    map[SalesTable.vehicleId] = sale.vehicleId;
    map[SalesTable.dealershipId] = sale.dealershipId;
    map[SalesTable.userId] = sale.userId;
    map[SalesTable.isComplete] = sale.isComplete ? 1 : 0;

    return map;
  }
}
