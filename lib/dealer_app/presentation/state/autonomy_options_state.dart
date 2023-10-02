import 'package:flutter/material.dart';

import '../../entities/autonomy_level.dart';
import '../../repository/database.dart';

class AutonomyOptionsState with ChangeNotifier {
  AutonomyOptionsState() {
    init();
  }

  final _autonomyController = AutonomyLevelsTableController();

  final _autonomyList = <AutonomyLevel>[];

  final formState = GlobalKey<FormState>();

  final _dealershipController = TextEditingController();
  final _headquartersController = TextEditingController();

  List<AutonomyLevel> get autonomyList => _autonomyList;
  TextEditingController get dealershipController => _dealershipController;
  TextEditingController get headquartersController => _headquartersController;

  void init() async {
    await getAutonomyList();
  }

  Future<void> getAutonomyList() async {
    final result = await _autonomyController.selectAll();

    _autonomyList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  void setControllerValues(AutonomyLevel autonomyLevel) {
    _dealershipController.text =
        (autonomyLevel.dealershipPercentage * 100).toString();
    _headquartersController.text =
        (autonomyLevel.headquartersPercentage * 100).toString();

    notifyListeners();
  }

  String? fieldValidator(String? value) {
    if (double.tryParse(dealershipController.text) == null) {
      return 'Please type the percentage';
    }
    if (double.parse(dealershipController.text).abs() +
            double.parse(headquartersController.text).abs() >
        99) {
      return 'This exceeds 100%';
    }
    if (double.parse(dealershipController.text).isNegative) {
      return "Value can't be negative";
    }
    return null;
  }

  Future<void> updatePercentage(AutonomyLevel autonomyLevel) async {
    final editedAutonomy = AutonomyLevel(
      id: autonomyLevel.id,
      name: autonomyLevel.name,
      dealershipPercentage: double.parse(_dealershipController.text) / 100,
      safetyPercentage: autonomyLevel.safetyPercentage,
      headquartersPercentage: double.parse(_headquartersController.text) / 100,
    );

    await _autonomyController.update(editedAutonomy);

    _dealershipController.clear();
    _headquartersController.clear();

    notifyListeners();
  }
}
