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
  late final String passwordController;
  late final int dealershipController;
  late final int roleController;

  TextEditingController get fullNameController => _fullNameController;
  TextEditingController get usernameController => _usernameController;

  Future<void> insert() async {
    final user = User(
      username: usernameController.text,
      password: passwordController,
      fullName: fullNameController.text,
      dealershipId: dealershipController,
      roleId: roleController,
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

    roleList.clear();
    dealershipList.clear();

    roleList.addAll(listOfRoles);
    dealershipList.addAll(listOfDealerships);

    notifyListeners();
  }
}
