import 'package:flutter/material.dart';

import '../../../entities/dealership.dart';
import '../../../entities/role.dart';
import '../../../entities/user.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../../usecases/database_controllers/roles_table_controller.dart';
import '../../../usecases/database_controllers/users_table_controller.dart';
import '../../pages/user/user_register_screen.dart';

/// State controller of [UserRegisterScreen] managing the data displayed.
class UserRegistraterState with ChangeNotifier {
  /// Constructs an instance of [UserRegisterScreen] with
  /// the given [user] parameter.
  UserRegistraterState(this.user) {
    _init(user);
  }

  /// The user being edited.
  User? user;

  /// All instances of [Role] saved on database.
  final roleList = <Role>[];

  /// All instances of [Dealership] saved on database.
  final dealershipList = <Dealership>[];

  /// The form controller of this screen.
  final formState = GlobalKey<FormState>();

  final _userTableController = UsersTableController();
  final _roleTableController = RolesTableController();
  final _dealershipTableController = DealershipsTableController();

  final _fullNameController = TextEditingController();

  /// The value inside full name text field.
  TextEditingController get fullNameController => _fullNameController;

  final _usernameController = TextEditingController();

  /// The value inside username text field.
  TextEditingController get usernameController => _usernameController;

  late String _passwordController;

  /// The password given by the dealership the user is being registered to.
  String get passwordController => _passwordController;

  late int _dealershipController;

  /// The value chosen from dealership dropdown.
  int get dealershipController => _dealershipController;

  late int _roleController;

  /// The value chosen from role dropdown.
  int get roleController => _roleController;

  /// Whether there is an user being edited or not.
  bool editing = false;

  void _init(User? user) async {
    await _load();

    if (user != null) {
      editing = true;
      _editUser(user);
    }
  }

  /// Creates a new instance of [User] inside the database.
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

  Future<void> _load() async {
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

  /// Sets the given [dealership] to [_dealershipController] and
  /// [dealership.password] to [_passwordController].
  void setDealershipValue(Dealership dealership) {
    _dealershipController = dealership.id!;
    _passwordController = dealership.password;
    notifyListeners();
  }

  /// Sets the given [role] to [_roleController].
  void setRoleValue(Role role) {
    _roleController = role.id!;
    notifyListeners();
  }

  void _editUser(User user) {
    usernameController.text = user.username;
    fullNameController.text = user.fullName;
    _roleController = user.roleId;
    _dealershipController = user.dealershipId;

    notifyListeners();
  }

  /// Updates an instance of [User] saved on database with
  /// the inputs from the user.
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

  /// Sets an instance of [User] as not active so it can't be used anymore.
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
