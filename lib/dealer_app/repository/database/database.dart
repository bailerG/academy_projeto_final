import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'autonomy_levels_table.dart';
import 'dealerships_table.dart';
import 'roles_table.dart';
import 'sales_table.dart';
import 'users_table.dart';
import 'vehicles_table.dart';

/// This opens the database for other methods to access and manipulate.
///
///
/// If the database isn't created yet, it creates all
/// tables and makes the necessary raw inserts needed.
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'anderson_automoveis.db',
  );
  log(path);

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(AutonomyLevelsTable.createTable);

      await db.rawInsert(AutonomyLevelsTable.starterRawInsert);
      await db.rawInsert(AutonomyLevelsTable.intermediateRawInsert);
      await db.rawInsert(AutonomyLevelsTable.advancedRawInsert);
      await db.rawInsert(AutonomyLevelsTable.specialRawInsert);

      await db.execute(DealershipsTable.createTable);

      await db.rawInsert(DealershipsTable.initialDealershipRawInsert);

      await db.execute(RolesTable.createTable);

      await db.rawInsert(RolesTable.adminRoleRawInsert);
      await db.rawInsert(RolesTable.associateRoleRawInsert);

      await db.execute(SalesTable.createTable);
      await db.execute(UsersTable.createTable);

      await db.rawInsert(UsersTable.adminUserRawInsert);

      await db.execute(VehiclesTable.createTable);
    },
    version: 1,
  );
}
