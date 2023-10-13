import 'package:flutter/material.dart';

import '../../../entities/dealership.dart';
import '../../../entities/role.dart';
import '../../../entities/user.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../../usecases/database_controllers/roles_table_controller.dart';
import '../../../usecases/database_controllers/users_table_controller.dart';
import '../../pages/user/user_list_screen.dart';

/// State controller of [UserListScreen] managing the data displayed.
class UserListState with ChangeNotifier {
  /// Constructs an instance of [UserListState].
  UserListState() {
    init();
  }

  /// Whether screen data is being loaded or not.
  bool loading = true;

  final _userController = UsersTableController();
  final _dealershipController = DealershipsTableController();
  final _roleController = RolesTableController();

  final _userList = <User>[];

  /// All instances of [User] saved on the database.
  List<User> get userList => _userList;

  final _dealershipList = <Dealership>[];

  /// All instances of [Dealership] saved on the database.
  List<Dealership> get dealershipList => _dealershipList;

  final _roleList = <Role>[];

  /// All instances of [Role] saved on the database.
  List<Role> get roleList => _roleList;

  /// Loads all data displayed on [UserListScreen].
  void init() async {
    loading = true;
    await _getUserList();
    await _getDealershipList();
    await _getRoleList();

    loading = false;

    notifyListeners();
  }

  Future<void> _getUserList() async {
    final result = await _userController.selectAll();
    _userList
      ..clear()
      ..addAll(result)
      ..sort(
        (a, b) => a.isActive.toString().compareTo(b.isActive.toString()),
      );

    notifyListeners();
  }

  Future<void> _getDealershipList() async {
    final result = await _dealershipController.selectAll();
    _dealershipList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  Future<void> _getRoleList() async {
    final result = await _roleController.selectAll();
    _roleList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }
}
