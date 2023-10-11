import 'package:flutter/material.dart';

import '../../../entities/dealership.dart';
import '../../../entities/role.dart';
import '../../../entities/user.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../../usecases/database_controllers/roles_table_controller.dart';
import '../../../usecases/database_controllers/users_table_controller.dart';

class UserListState with ChangeNotifier {
  UserListState() {
    init();
  }

  bool loading = true;

  final _userController = UsersTableController();
  final _dealershipController = DealershipsTableController();
  final _roleController = RolesTableController();

  final _userList = <User>[];
  final _dealershipList = <Dealership>[];
  final _roleList = <Role>[];

  List<User> get userList => _userList;
  List<Dealership> get dealershipList => _dealershipList;
  List<Role> get roleList => _roleList;

  void init() async {
    loading = true;
    await getUserList();
    await getDealershipList();
    await getRoleList();

    loading = false;

    notifyListeners();
  }

  Future<void> getUserList() async {
    final result = await _userController.selectAll();
    _userList
      ..clear()
      ..addAll(result)
      ..sort(
        (a, b) => a.isActive.toString().compareTo(b.isActive.toString()),
      );

    notifyListeners();
  }

  Future<void> getDealershipList() async {
    final result = await _dealershipController.selectAll();
    _dealershipList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  Future<void> getRoleList() async {
    final result = await _roleController.selectAll();
    _roleList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }
}
