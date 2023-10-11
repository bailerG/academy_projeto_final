// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/autonomy_level.dart';

/// The database table for [AutonomyLevel]
///
///
/// It stores all parameters such as [AutonomyLevel.id],[AutonomyLevel.name],
/// [AutonomyLevel.dealershipPercentage], [AutonomyLevel.safetyPercentage],
/// [AutonomyLevel.headquartersPercentage] inside a .db file.
class AutonomyLevelsTable {
  /// This is a SQLite command for creating this table.
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $name TEXT NOT NULL,
      $dealershipPercentage REAL NOT NULL,
      $safetyPercentage REAL NOT NULL,
      $headquartersPercentage REAL NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'autonomy_level';

  /// [AutonomyLevel.id] column name reference.
  static const String id = 'id';

  /// [AutonomyLevel.name] column name reference.
  static const String name = 'name';

  /// [AutonomyLevel.dealershipPercentage] column name reference.
  static const String dealershipPercentage = 'dealership_percentage';

  /// [AutonomyLevel.safetyPercentage] column name reference.
  static const String safetyPercentage = 'safety_percentage';

  /// [AutonomyLevel.headquartersPercentage] column name reference.
  static const String headquartersPercentage = 'headquarters_percentage';

  /// Inserts the [Iniciante] autonomy level when database is created.
  static const starterRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Iniciante",0.74,0.01,0.25)';

  /// Inserts the [Intermediario] autonomy level when database is created.
  static const intermediateRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Intermediario",0.79,0.01,0.20)';

  /// Inserts the [Avancado] autonomy level when database is created.
  static const advancedRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Avancado",0.84,0.01,0.15)';

  /// Inserts the [Especial] autonomy level when database is created.
  static const specialRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Especial",0.94,0.01,0.05)';

  /// Transforms a given [autonomyLevel] into a map.
  static Map<String, dynamic> toMap(AutonomyLevel autonomyLevel) {
    final map = <String, dynamic>{};

    map[AutonomyLevelsTable.id] = autonomyLevel.id;
    map[AutonomyLevelsTable.name] = autonomyLevel.name;
    map[AutonomyLevelsTable.dealershipPercentage] =
        autonomyLevel.dealershipPercentage;
    map[AutonomyLevelsTable.safetyPercentage] = autonomyLevel.safetyPercentage;
    map[AutonomyLevelsTable.headquartersPercentage] =
        autonomyLevel.headquartersPercentage;

    return map;
  }
}
