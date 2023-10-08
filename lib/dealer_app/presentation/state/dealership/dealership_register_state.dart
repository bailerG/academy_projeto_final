import 'dart:math';

import 'package:flutter/material.dart';

import '../../../entities/autonomy_level.dart';
import '../../../entities/dealership.dart';
import '../../../repository/database.dart';

class DealershipRegisterState with ChangeNotifier {
  DealershipRegisterState(this._dealership) {
    init();
  }

  final Dealership? _dealership;

  final autonomyList = <AutonomyLevel>[];

  final formState = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _passwordController = TextEditingController();
  late int _autonomyController;

  TextEditingController get nameController => _nameController;
  TextEditingController get cnpjController => _cnpjController;
  TextEditingController get passwordController => _passwordController;
  int get autonomyController => _autonomyController;

  final _dealershipTableController = DealershipsTableController();
  final _autonomyTableController = AutonomyLevelsTableController();

  bool editing = false;

  void init() async {
    await getAutonomyList();

    if (_dealership != null) {
      editing = true;
      editDealership(_dealership!);
    }
  }

  Future<void> getAutonomyList() async {
    final result = await _autonomyTableController.selectAll();
    autonomyList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  void setAutonomyLevel(AutonomyLevel level) {
    _autonomyController = level.id!;

    notifyListeners();
  }

  void generatePassword() {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final random = Random();

    final password = String.fromCharCodes(Iterable.generate(
        8, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
    _passwordController.text = password;

    notifyListeners();
  }

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

  void editDealership(Dealership dealership) {
    _cnpjController.text = dealership.cnpj.toString();
    _nameController.text = dealership.name;
    _passwordController.text = dealership.password;
    _autonomyController = dealership.autonomyLevelId;

    notifyListeners();
  }
}
