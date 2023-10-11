// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/dealership.dart';

/// The database table for [Dealership]
/// .
/// .
/// It stores all variables such as [Dealership.id],[Dealership.cnpj],
/// [Dealership.name],[Dealership.autonomyLevelId], [Dealership.password],
/// [Dealership.isActive] inside a .db file.
class DealershipsTable {
  /// This is a SQLite command for creating this table.
  static const String createTable = ''' 
    CREATE TABLE $tableName(
      $id               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj             INTEGER NOT NULL,
      $name             TEXT NOT NULL,
      $autonomyLevelId  INTEGER NOT NULL,
      $password         TEXT NOT NULL,
      $isActive         INTEGER NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'dealership';

  /// [Dealership.id] column name reference.
  static const String id = 'id';

  /// [Dealership.cnpj] column name reference.
  static const String cnpj = 'cnpj';

  /// [Dealership.name] column name reference.
  static const String name = 'name';

  /// [Dealership.autonomyLevelId] column name reference.
  static const String autonomyLevelId = 'autonomy_level_id';

  /// [Dealership.password] column name reference.
  static const String password = 'password';

  /// [Dealership.isActive] column name reference.
  static const String isActive = 'is_active';

  /// Inserts the headquarters dealership when database is created.
  static const initialDealershipRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$autonomyLevelId,$password,$isActive)'
      'VALUES(79558908000175,"Matriz",4,"anderson",1)';

  /// Transforms a given [dealership] into a map.
  static Map<String, dynamic> toMap(Dealership dealership) {
    final map = <String, dynamic>{};

    map[DealershipsTable.id] = dealership.id;
    map[DealershipsTable.cnpj] = dealership.cnpj;
    map[DealershipsTable.name] = dealership.name;
    map[DealershipsTable.autonomyLevelId] = dealership.autonomyLevelId;
    map[DealershipsTable.password] = dealership.password;
    map[DealershipsTable.isActive] = dealership.isActive ? 1 : 0;

    return map;
  }
}
