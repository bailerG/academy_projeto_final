import 'package:flutter/material.dart';

import '../../entities/dealership.dart';
import '../../entities/role.dart';
import '../../entities/user.dart';
import '../../repository/database.dart';

class UserListState with ChangeNotifier {
  UserListState() {
    init();
  }

  bool loading = true;

  final userController = UsersTableController();
  final dealershipController = DealershipTableController();
  final roleController = RolesTableController();

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
    final result = await userController.selectAll();
    _userList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  Future<void> getDealershipList() async {
    final result = await dealershipController.selectAll();
    _dealershipList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  Future<void> getRoleList() async {
    final result = await roleController.selectAll();
    _roleList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }
}
