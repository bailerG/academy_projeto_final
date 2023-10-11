// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/autonomy_level.dart';
import '../../repository/database/autonomy_levels_table.dart';
import '../../repository/database/database.dart';

/// The controller for [AutonomyLevelsTable]
/// .
/// .
/// It contains all the methods used to manipulate table's data.
class AutonomyLevelsTableController {
  /// Returns all instances of [AutonomyLevel] saved on database as a list.
  Future<List<AutonomyLevel>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      AutonomyLevelsTable.tableName,
    );

    var list = <AutonomyLevel>[];

    for (final item in result) {
      list.add(
        AutonomyLevel(
          id: item[AutonomyLevelsTable.id],
          name: item[AutonomyLevelsTable.name],
          dealershipPercentage: item[AutonomyLevelsTable.dealershipPercentage],
          safetyPercentage: item[AutonomyLevelsTable.safetyPercentage],
          headquartersPercentage:
              item[AutonomyLevelsTable.headquartersPercentage],
        ),
      );
    }
    return list;
  }

  /// Returns a single [AutonomyLevel] from database given its [id].
  Future<AutonomyLevel> selectById(int id) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      AutonomyLevelsTable.tableName,
      where: '${AutonomyLevelsTable.id} = ?',
      whereArgs: [id],
    );

    final AutonomyLevel autonomyLevel;

    if (result.length == 1) {
      autonomyLevel = AutonomyLevel(
        id: result.first[AutonomyLevelsTable.id],
        name: result.first[AutonomyLevelsTable.name],
        dealershipPercentage:
            result.first[AutonomyLevelsTable.dealershipPercentage],
        safetyPercentage: result.first[AutonomyLevelsTable.safetyPercentage],
        headquartersPercentage:
            result.first[AutonomyLevelsTable.headquartersPercentage],
      );
    } else {
      throw Exception('More than one dealership with same id');
    }

    return autonomyLevel;
  }

  /// Updates the given [autonomyLevel] data contained in the database
  Future<void> update(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();

    final map = AutonomyLevelsTable.toMap(autonomyLevel);

    await database.update(
      AutonomyLevelsTable.tableName,
      map,
      where: '${AutonomyLevelsTable.id} = ?',
      whereArgs: [autonomyLevel.id],
    );

    return;
  }
}
