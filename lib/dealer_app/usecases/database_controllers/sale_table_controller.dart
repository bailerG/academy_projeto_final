// ignore_for_file: avoid_classes_with_only_static_members

import '../../entities/sale.dart';
import '../../repository/database/database.dart';
import '../../repository/database/sales_table.dart';
import 'package:intl/intl.dart';

/// The controller for [SalesTable]
///
///
/// It contains all the methods used to manipulate table's data.
class SaleTableController {
  /// Inserts the given [sale] into database.
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    await database.insert(
      SalesTable.tableName,
      map,
    );

    return;
  }

  /// Returns all instances of [Sale] saved on database
  /// as a list filtered by [dealershipId].
  Future<List<Sale>> selectByDealership(int dealershipId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.dealershipId} = ?',
      whereArgs: [dealershipId],
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: DateFormat('dd/MM/yyyy').parse(item[SalesTable.soldWhen]),
          priceSold: item[SalesTable.priceSold],
          dealershipPercentage: item[SalesTable.dealershipPercentage],
          headquartersPercentage: item[SalesTable.headquartersPercentage],
          safetyPercentage: item[SalesTable.safetyPercentage],
          vehicleId: item[SalesTable.vehicleId],
          dealershipId: item[SalesTable.dealershipId],
          userId: item[SalesTable.userId],
          isComplete: item[SalesTable.isComplete] == 1 ? true : false,
        ),
      );
    }
    return list;
  }

  /// Updates the given [sale] data contained in the database
  Future<void> update(Sale sale) async {
    final database = await getDatabase();

    final map = SalesTable.toMap(sale);

    await database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          SalesTable.tableName,
          map,
          where: '${SalesTable.id} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}
