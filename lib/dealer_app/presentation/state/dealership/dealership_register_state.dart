import 'dart:math';

import 'package:flutter/material.dart';

import '../../../entities/autonomy_level.dart';
import '../../../entities/dealership.dart';
import '../../../usecases/database_controllers/autonomy_table_controller.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../pages/dealership/dealership_register_screen.dart';

/// State controller of [DealershipRegisterScreen] managing the data displayed.
class DealershipRegisterState with ChangeNotifier {
  /// Constructs an instance of [DealershipRegisterState] with
  /// the given [_dealership] parameter.
  DealershipRegisterState(this._dealership) {
    _init();
  }

  final Dealership? _dealership;

  /// All instances of [AutonomyLevel] registered on database.
  final autonomyList = <AutonomyLevel>[];

  /// The form controller of this screen.
  final formState = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  /// The value inside name text field.
  TextEditingController get nameController => _nameController;

  final _cnpjController = TextEditingController();

  /// The value inside cnpj text field.
  TextEditingController get cnpjController => _cnpjController;

  final _passwordController = TextEditingController();

  /// The value inside password text field.
  TextEditingController get passwordController => _passwordController;

  late int _autonomyController;

  /// The value inside autonomy dropdown.
  int get autonomyController => _autonomyController;

  final _dealershipTableController = DealershipsTableController();
  final _autonomyTableController = AutonomyLevelsTableController();

  /// Whether there is an instance of [Dealership] being edited or not.
  bool editing = false;

  void _init() async {
    await _getAutonomyList();

    if (_dealership != null) {
      editing = true;
      _editDealership(_dealership!);
    }
  }

  Future<void> _getAutonomyList() async {
    final result = await _autonomyTableController.selectAll();
    autonomyList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  /// Sets the [autonomyController] for the dealership being registered.
  void setAutonomyLevel(AutonomyLevel autonomyLevel) {
    _autonomyController = autonomyLevel.id!;

    notifyListeners();
  }

  /// Generates a random string that will be used as password.
  void generatePassword() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final random = Random();

    final password = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    _passwordController.text = password;

    notifyListeners();
  }

  /// Creates an instance of [Dealership] into the database.
  Future<void> insert() async {
    final newDealership = Dealership(
      cnpj: int.parse(_cnpjController.text),
      name: _nameController.text,
      autonomyLevelId: _autonomyController,
      password: _passwordController.text,
      isActive: true,
    );

    await _dealershipTableController.insert(newDealership);

    _cnpjController.clear();
    _nameController.clear();
    _passwordController.clear();
    _autonomyController = 0;

    notifyListeners();
  }

  /// Updates an instance of [Dealership] saved on the database with
  /// the given parameters from the user.
  Future<void> update() async {
    final editedDealership = Dealership(
      id: _dealership!.id,
      cnpj: int.parse(_cnpjController.text),
      name: _nameController.text,
      autonomyLevelId: _autonomyController,
      password: _passwordController.text,
      isActive: true,
    );

    await _dealershipTableController.update(editedDealership);

    _cnpjController.clear();
    _nameController.clear();
    _passwordController.clear();
    _autonomyController = 0;

    notifyListeners();
  }

  /// Makes the dealership inactive, so it can't be used anymore.
  Future<void> deactivateDealership() async {
    final deactivatedDealership = Dealership(
      id: _dealership!.id,
      cnpj: _dealership!.cnpj,
      name: _dealership!.name,
      autonomyLevelId: _dealership!.autonomyLevelId,
      password: _dealership!.password,
      isActive: false,
    );

    await _dealershipTableController.update(deactivatedDealership);

    notifyListeners();
  }

  void _editDealership(Dealership dealership) {
    _cnpjController.text = dealership.cnpj.toString();
    _nameController.text = dealership.name;
    _passwordController.text = dealership.password;
    _autonomyController = dealership.autonomyLevelId;

    notifyListeners();
  }
}
