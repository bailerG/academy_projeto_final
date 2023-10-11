// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/dealership.dart';
import '../../repository/database/database.dart';
import '../../repository/database/dealerships_table.dart';
import '../../repository/database/vehicles_table.dart';

/// The controller for [DealershipsTable]
///
///
/// It contains all the methods used to manipulate table's data.
class DealershipsTableController {
  /// Inserts the given [dealership] into database.
  Future<void> insert(Dealership dealership) async {
    final database = await getDatabase();
    final map = DealershipsTable.toMap(dealership);

    await database.insert(
      DealershipsTable.tableName,
      map,
    );

    return;
  }

  /// Deletes a given [dealership] and all cars registered to it.
  Future<void> delete(Dealership dealership) async {
    final database = await getDatabase();

    await database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          DealershipsTable.tableName,
          where: '${DealershipsTable.id} = ?',
          whereArgs: [dealership.id],
        );

        batch.delete(
          VehiclesTable.tableName,
          where: '${VehiclesTable.dealershipId} = ?',
          whereArgs: [dealership.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  /// Returns all instances of [Dealership] saved on database as a list.
  Future<List<Dealership>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      DealershipsTable.tableName,
    );

    var list = <Dealership>[];

    for (final item in result) {
      list.add(
        Dealership(
          id: item[DealershipsTable.id],
          cnpj: item[DealershipsTable.cnpj],
          name: item[DealershipsTable.name],
          autonomyLevelId: item[DealershipsTable.autonomyLevelId],
          password: item[DealershipsTable.password],
          isActive: item[DealershipsTable.isActive] == 1 ? true : false,
        ),
      );
    }
    return list;
  }

  /// Returns a single [Dealership] from database given its [id].
  Future<Dealership> selectById(int id) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      DealershipsTable.tableName,
      where: '${DealershipsTable.id} = ?',
      whereArgs: [id],
    );

    final Dealership dealership;

    if (result.length == 1) {
      dealership = Dealership(
        id: result.first[DealershipsTable.id],
        cnpj: result.first[DealershipsTable.cnpj],
        name: result.first[DealershipsTable.name],
        autonomyLevelId: result.first[DealershipsTable.autonomyLevelId],
        password: result.first[DealershipsTable.password],
        isActive: result.first[DealershipsTable.isActive] == 1 ? true : false,
      );
    } else {
      throw Exception('More than one dealership with same id');
    }

    return dealership;
  }

  /// Updates the given [dealership] data contained in the database
  Future<void> update(Dealership dealership) async {
    final database = await getDatabase();

    final map = DealershipsTable.toMap(dealership);

    await database.update(
      DealershipsTable.tableName,
      map,
      where: '${DealershipsTable.id} = ?',
      whereArgs: [dealership.id],
    );

    return;
  }
}
