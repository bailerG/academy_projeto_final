import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/autonomy_level.dart';
import '../entities/dealership.dart';
import '../entities/role.dart';
import '../entities/sale.dart';
import '../entities/user.dart';
import '../entities/vehicle.dart';

// This method searches for the database's path and opens it
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

// This is the database constructor
class AutonomyLevelsTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $name TEXT NOT NULL,
      $dealershipPercentage REAL NOT NULL,
      $safetyPercentage REAL NOT NULL,
      $headquartersPercentage REAL NOT NULL
    );
  ''';

  static const String tableName = 'autonomy_level';
  static const String id = 'id';
  static const String name = 'name';
  static const String dealershipPercentage = 'dealership_percentage';
  static const String safetyPercentage = 'safety_percentage';
  static const String headquartersPercentage = 'headquarters_percentage';

  static const starterRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Iniciante",0.74,0.01,0.25)';

  static const intermediateRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Intermediario",0.79,0.01,0.20)';

  static const advancedRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Avancado",0.84,0.01,0.15)';

  static const specialRawInsert =
      'INSERT INTO $tableName($name,$dealershipPercentage,$safetyPercentage,'
      '$headquartersPercentage) VALUES("Especial",0.94,0.01,0.05)';

  // This method translates the table's data to a map
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

// This controller is responsable for manipulating the database
class AutonomyLevelsTableController {
  // Insert method serves for adding new items into the database
  Future<void> insert(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();
    final map = AutonomyLevelsTable.toMap(autonomyLevel);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          AutonomyLevelsTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          AutonomyLevelsTable.tableName,
          where: '${AutonomyLevelsTable.id} = ?',
          whereArgs: [autonomyLevel.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of all the items registered on the database
  Future<List<AutonomyLevel>> select() async {
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

  // Update method updates the object on the database
  Future<void> update(AutonomyLevel autonomyLevel) async {
    final database = await getDatabase();

    final map = AutonomyLevelsTable.toMap(autonomyLevel);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          AutonomyLevelsTable.tableName,
          map,
          where: '${AutonomyLevelsTable.id} = ?',
          whereArgs: [autonomyLevel.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}

// This is the database constructor
class DealershipsTable {
  static const String createTable = ''' 
    CREATE TABLE $tableName(
      $id               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj             INTEGER NOT NULL,
      $name             TEXT NOT NULL,
      $autonomyLevelId  INTEGER NOT NULL,
      $password         TEXT NOT NULL
    );
  ''';

  static const String tableName = 'dealership';
  static const String id = 'id';
  static const String cnpj = 'cnpj';
  static const String name = 'name';
  static const String autonomyLevelId = 'autonomy_level_id';
  static const String password = 'password';

  static const initialDealershipRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$autonomyLevelId,$password) '
      'VALUES(79558908000175,"Matriz",4,"anderson")';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Dealership dealership) {
    final map = <String, dynamic>{};

    map[DealershipsTable.id] = dealership.id;
    map[DealershipsTable.cnpj] = dealership.cnpj;
    map[DealershipsTable.name] = dealership.name;
    map[DealershipsTable.autonomyLevelId] = dealership.autonomyLevelId;
    map[DealershipsTable.password] = dealership.password;

    return map;
  }
}

// This controller is responsable for manipulating the database
class DealershipTableController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Dealership dealership) async {
    final database = await getDatabase();
    final map = DealershipsTable.toMap(dealership);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          DealershipsTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
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
          SalesTable.tableName,
          where: '${SalesTable.dealershipId} = ?',
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

  // Select method returns a list of all the items registered on the database
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
        ),
      );
    }
    return list;
  }

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
      );
    } else {
      throw Exception('More than one dealership with same id');
    }

    return dealership;
  }

  // Update method updates the object on the database
  Future<void> update(Dealership dealership) async {
    final database = await getDatabase();

    final map = DealershipsTable.toMap(dealership);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          DealershipsTable.tableName,
          map,
          where: '${DealershipsTable.id} = ?',
          whereArgs: [dealership.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}

// This is the database constructor
class RolesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $roleName   TEXT NOT NULL
    );
  ''';

  static const String tableName = 'role';
  static const String id = 'id';
  static const String roleName = 'role_name';

  static const adminRoleRawInsert =
      'INSERT INTO $tableName($roleName) VALUES("Admin")';

  static const associateRoleRawInsert =
      'INSERT INTO $tableName($roleName) VALUES("Associado")';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Role role) {
    final map = <String, dynamic>{};

    map[RolesTable.id] = role.id;
    map[RolesTable.roleName] = role.roleName;

    return map;
  }
}

// This controller is responsable for manipulating the database
class RolesTableController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Role role) async {
    final database = await getDatabase();
    final map = RolesTable.toMap(role);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          RolesTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(Role role) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          DealershipsTable.tableName,
          where: '${RolesTable.id} = ?',
          whereArgs: [role.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items registered on the database with
  //the given dealership id
  Future<List<Role>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      RolesTable.tableName,
    );

    var list = <Role>[];

    for (final item in result) {
      list.add(
        Role(
          id: item[RolesTable.id],
          roleName: item[RolesTable.roleName],
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(Role role) async {
    final database = await getDatabase();

    final map = RolesTable.toMap(role);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          RolesTable.tableName,
          map,
          where: '${RolesTable.id} = ?',
          whereArgs: [role.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}

// This is the database constructor
class SalesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerCpf    INTEGER NOT NULL,
      $customerName   TEXT NOT NULL,
      $soldWhen       TEXT NOT NULL,
      $priceSold      REAL NOT NULL,
      $dealershipCut  REAL NOT NULL,
      $businessCut    REAL NOT NULL,
      $safetyCut      REAL NOT NULL,
      $vehicleId      INTERGER NOT NULL,
      $dealershipId   INTEGER NOT NULL,
      $userId         INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'sale';
  static const String id = 'id';
  static const String customerCpf = 'customer_cpf';
  static const String customerName = 'customer_name';
  static const String soldWhen = 'sold_when';
  static const String priceSold = 'price_sold';
  static const String dealershipCut = 'dealership_cut';
  static const String businessCut = 'business_cut';
  static const String safetyCut = 'safety_cut';
  static const String vehicleId = 'vehicle_id';
  static const String dealershipId = 'dealership_id';
  static const String userId = 'user_id';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[SalesTable.id] = sale.id;
    map[SalesTable.customerCpf] = sale.customerCpf;
    map[SalesTable.customerName] = sale.customerName;
    map[SalesTable.soldWhen] = DateFormat('dd/MM/yyyy').format(sale.soldWhen);
    map[SalesTable.priceSold] = sale.priceSold;
    map[SalesTable.dealershipCut] = sale.dealershipPercentage;
    map[SalesTable.businessCut] = sale.businessPercentage;
    map[SalesTable.safetyCut] = sale.safetyPercentage;
    map[SalesTable.vehicleId] = sale.vehicleId;
    map[SalesTable.dealershipId] = sale.dealershipId;
    map[SalesTable.userId] = sale.userId;

    return map;
  }
}

// This controller is responsable for manipulating the database
class SaleTableController {
  // Insert method serves for adding new items into the database
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          SalesTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(Sale sale) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          SalesTable.tableName,
          where: '${SalesTable.id} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items
  // registered on the database with the given dealership id
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
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipPercentage: item[SalesTable.dealershipCut],
          businessPercentage: item[SalesTable.businessCut],
          safetyPercentage: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          dealershipId: item[SalesTable.dealershipId],
          userId: item[SalesTable.userId],
        ),
      );
    }
    return list;
  }

// Select method returns a list of the items
// registered on the database with the given vehicle id
  Future<List<Sale>> selectByVehicle(int vehicleId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.vehicleId} = ?',
      whereArgs: [vehicleId],
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          customerCpf: item[SalesTable.customerCpf],
          customerName: item[SalesTable.customerName],
          soldWhen: item[SalesTable.soldWhen],
          priceSold: item[SalesTable.priceSold],
          dealershipPercentage: item[SalesTable.dealershipCut],
          businessPercentage: item[SalesTable.businessCut],
          safetyPercentage: item[SalesTable.safetyCut],
          vehicleId: item[SalesTable.vehicleId],
          dealershipId: item[SalesTable.dealershipId],
          userId: item[SalesTable.userId],
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(Sale sale) async {
    final database = await getDatabase();

    final map = SalesTable.toMap(sale);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          SalesTable.tableName,
          map,
          where: '${SalesTable.tableName} = ?',
          whereArgs: [sale.id],
        );

        await batch.commit();
      },
    );

    return;
  }
}

// This is the database constructor
class UsersTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $username     TEXT NOT NULL,
      $password     TEXT NOT NULL,
      $fullName     TEXT NOT NULL,
      $dealershipId INTEGER NOT NULL,
      $roleId       INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'user';
  static const String id = 'id';
  static const String username = 'username';
  static const String password = 'password';
  static const String fullName = 'full_name';
  static const String dealershipId = 'dealership_id';
  static const String roleId = 'role_id';

  static const adminUserRawInsert =
      'INSERT INTO $tableName($username,$password,$fullName,$dealershipId,'
      '$roleId) VALUES("admin","admin","Anderson",1,1)';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(User user) {
    final map = <String, dynamic>{};

    map[UsersTable.id] = user.id;
    map[UsersTable.username] = user.username;
    map[UsersTable.password] = user.password;
    map[UsersTable.fullName] = user.fullName;
    map[UsersTable.dealershipId] = user.dealershipId;
    map[UsersTable.roleId] = user.roleId;

    return map;
  }
}

// This controller is responsable for manipulating the database
class UsersTableController {
  // Insert method serves for adding new items into the database
  Future<void> insert(User user) async {
    final database = await getDatabase();
    final map = UsersTable.toMap(user);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.insert(
          UsersTable.tableName,
          map,
        );

        await batch.commit();
      },
    );

    return;
  }

  // Delete method for deleting a given object from the database
  Future<void> delete(User user) async {
    final database = await getDatabase();

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.delete(
          UsersTable.tableName,
          where: '${UsersTable.id} = ?',
          whereArgs: [user.id],
        );

        await batch.commit();
      },
    );

    return;
  }

  // Select method returns a list of the items registered on the database with
  //the given dealership id
  Future<List<User>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      UsersTable.tableName,
    );

    var list = <User>[];

    for (final item in result) {
      list.add(
        User(
          id: item[UsersTable.id],
          username: item[UsersTable.username],
          password: item[UsersTable.password],
          fullName: item[UsersTable.fullName],
          dealershipId: item[UsersTable.dealershipId],
          roleId: item[UsersTable.roleId],
        ),
      );
    }
    return list;
  }

  Future<List<User>> selectByUsername(String username) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      UsersTable.tableName,
      where: '${UsersTable.username} = ?',
      whereArgs: [username],
    );

    var list = <User>[];

    for (final item in result) {
      list.add(
        User(
          id: item[UsersTable.id],
          username: item[UsersTable.username],
          password: item[UsersTable.password],
          fullName: item[UsersTable.fullName],
          dealershipId: item[UsersTable.dealershipId],
          roleId: item[UsersTable.roleId],
        ),
      );
    }
    return list;
  }

  // Update method updates the object on the database
  Future<void> update(User user) async {
    final database = await getDatabase();

    final map = UsersTable.toMap(user);

    database.transaction(
      (txn) async {
        final batch = txn.batch();

        batch.update(
          UsersTable.tableName,
          map,
          where: '${UsersTable.id} = ?',
          whereArgs: [user.id],
        );

        await batch.commit();
      },
    );

    return;
  }
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
      $dealershipId   INTEGER NOT NULL,
      $isSold         INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'vehicle';
  static const String id = 'id';
  static const String model = 'model';
  static const String plate = 'plate';
  static const String brand = 'brand';
  static const String builtYear = 'built_year';
  static const String modelYear = 'model_year';
  static const String photo = 'photo';
  static const String pricePaid = 'price_paid';
  static const String purchasedWhen = 'purchased_when';
  static const String dealershipId = 'dealership_id';
  static const String isSold = 'is_sold';

  // This method translates the table's data to a map
  static Map<String, dynamic> toMap(Vehicle vehicle) {
    final map = <String, dynamic>{};

    map[VehiclesTable.id] = vehicle.id;
    map[VehiclesTable.model] = vehicle.model;
    map[VehiclesTable.plate] = vehicle.plate;
    map[VehiclesTable.brand] = vehicle.brand;
    map[VehiclesTable.builtYear] = vehicle.builtYear;
    map[VehiclesTable.modelYear] = vehicle.modelYear;
    map[VehiclesTable.photo] = vehicle.photos;
    map[VehiclesTable.pricePaid] = vehicle.pricePaid.toStringAsFixed(2);
    map[VehiclesTable.purchasedWhen] =
        DateFormat('dd/MM/yyyy').format(vehicle.purchasedWhen);
    map[VehiclesTable.dealershipId] = vehicle.dealershipId;
    map[VehiclesTable.isSold] = vehicle.isSold ? 1 : 0;

    return map;
  }
}

// This controller is responsable for manipulating the database
class VehiclesTableController {
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

  // Select method returns a list of the items registered on the database with
  //the given dealership id
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
          photos: (item[VehiclesTable.photo]).toString(),
          pricePaid: item[VehiclesTable.pricePaid],
          purchasedWhen:
              DateFormat('dd/MM/yyyy').parse(item[VehiclesTable.purchasedWhen]),
          dealershipId: item[VehiclesTable.dealershipId],
          isSold: item[VehiclesTable.isSold] == 1 ? true : false,
        ),
      );
    }
    return list;
  }

  Future<List<Vehicle>> selectSingleVehicle(int vehicleId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      VehiclesTable.tableName,
      where: '${VehiclesTable.id} = ?',
      whereArgs: [vehicleId],
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
          photos: (item[VehiclesTable.photo]).toString(),
          pricePaid: item[VehiclesTable.pricePaid],
          purchasedWhen:
              DateFormat('dd/MM/yyyy').parse(item[VehiclesTable.purchasedWhen]),
          dealershipId: item[VehiclesTable.dealershipId],
          isSold: item[VehiclesTable.isSold] == 1 ? true : false,
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
