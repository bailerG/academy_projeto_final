import 'package:flutter/material.dart';

import '../../../entities/dealership.dart';
import '../../../entities/role.dart';
import '../../../entities/user.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../../usecases/database_controllers/roles_table_controller.dart';
import '../../../usecases/database_controllers/users_table_controller.dart';

class UserRegistrationState with ChangeNotifier {
  UserRegistrationState(this.user) {
    init(user);
  }

  User? user;

  final formState = GlobalKey<FormState>();

  final _userTableController = UsersTableController();
  final _roleTableController = RolesTableController();
  final _dealershipTableController = DealershipsTableController();

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

  bool editing = false;

  void init(User? user) async {
    await load();

    if (user != null) {
      editing = true;
      editUser(user);
    }
  }

  Future<void> insert() async {
    final user = User(
      username: usernameController.text,
      password: passwordController,
      fullName: fullNameController.text,
      dealershipId: dealershipController,
      roleId: roleController,
      isActive: true,
    );

    await _userTableController.insert(user);

    fullNameController.clear();
    usernameController.clear();

    notifyListeners();
  }

  final roleList = <Role>[];
  final dealershipList = <Dealership>[];

  Future<void> load() async {
    final listOfRoles = await _roleTableController.selectAll();
    final listOfDealerships = await _dealershipTableController.selectAll();

    roleList
      ..clear()
      ..addAll(listOfRoles);
    dealershipList
      ..clear()
      ..addAll(listOfDealerships)
      ..removeWhere((element) => element.isActive == false);

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

  void editUser(User user) {
    usernameController.text = user.username;
    fullNameController.text = user.fullName;
    _roleController = user.roleId;
    _dealershipController = user.dealershipId;

    notifyListeners();
  }

  Future<void> update() async {
    final editedUser = User(
      id: user!.id,
      username: usernameController.text,
      password: user!.password,
      fullName: fullNameController.text,
      dealershipId: dealershipController,
      roleId: roleController,
      isActive: true,
    );

    await _userTableController.update(editedUser);

    fullNameController.clear();
    usernameController.clear();

    notifyListeners();
  }

  Future<void> deactivateUser() async {
    final deactivatedUser = User(
      id: user!.id,
      username: user!.username,
      password: user!.password,
      fullName: user!.fullName,
      dealershipId: user!.dealershipId,
      roleId: user!.roleId,
      isActive: false,
    );

    await _userTableController.update(deactivatedUser);

    notifyListeners();
  }
}
