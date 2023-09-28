import 'package:flutter/material.dart';

import '../../entities/dealership.dart';
import '../../entities/role.dart';
import '../../entities/user.dart';
import '../../repository/database.dart';

class UserRegistrationState with ChangeNotifier {
  UserRegistrationState(this.user) {
    init(user);
  }

  User? user;

  final formState = GlobalKey<FormState>();

  final _userController = UsersTableController();

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
    editing = false;

    load();

    if (user != null) {
      editUser(user);
      editing = true;
    }
  }

  Future<void> insert() async {
    final user = User(
      username: usernameController.text,
      password: passwordController,
      fullName: fullNameController.text,
      dealershipId: dealershipController,
      roleId: roleController,
    );

    await _userController.insert(user);

    fullNameController.clear();
    usernameController.clear();

    notifyListeners();
  }

  final roleList = <Role>[];
  final dealershipList = <Dealership>[];

  Future<void> load() async {
    final listOfRoles = await RolesTableController().selectAll();
    final listOfDealerships = await DealershipTableController().selectAll();

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
    );

    await _userController.update(editedUser);

    fullNameController.clear();
    usernameController.clear();

    notifyListeners();
  }
}
