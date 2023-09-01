import 'package:flutter/material.dart';

import '../../entities/dealership.dart';
import '../../entities/role.dart';
import '../../entities/user.dart';
import '../../repository/database.dart';

class UserRegistrationState with ChangeNotifier {
  UserRegistrationState() {
    load();
  }

  final formState = GlobalKey<FormState>();

  final userController = UsersTableController();

  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  late String _passwordController;
  late int _dealershipController;
  late int _roleController;

  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get usernameController => _usernameController;
  String get passwordController => _passwordController;
  int get dealershipController => _dealershipController;
  int get roleController => _roleController;

  Future<void> insert() async {
    final user = User(
      username: usernameController.text,
      password: passwordController,
      fullName: fullNameController.text,
      dealershipId: dealershipController,
      roleId: _roleController,
    );

    await userController.insert(user);

    fullNameController.clear();
    usernameController.clear();

    notifyListeners();
  }

  final roleList = <Role>[];
  final dealershipList = <Dealership>[];

  Future<void> load() async {
    final listOfRoles = await RolesTableController().select();
    final listOfDealerships = await DealershipTableController().select();

    roleList
      ..clear()
      ..addAll(listOfRoles);
    dealershipList
      ..clear()
      ..addAll(listOfDealerships);

    notifyListeners();
  }

  void setDealershipValue(Dealership dealership) {
    _dealershipController = dealership.id!;
    _passwordController = dealership.password;
    notifyListeners();
  }

  void setRoleValue(Role role) {
    _roleController = role.id!;
    notifyListeners();
  }
}
