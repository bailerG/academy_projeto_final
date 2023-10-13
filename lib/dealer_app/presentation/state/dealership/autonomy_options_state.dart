import 'package:flutter/material.dart';

import '../../../entities/autonomy_level.dart';
import '../../../usecases/database_controllers/autonomy_table_controller.dart';
import '../../pages/dealership/autonomy_options.dart';

/// State controller of [AutonomyOptionsScreen] managing the data displayed.
class AutonomyOptionsState with ChangeNotifier {
  /// Constructs an instance of [AutonomyOptionsState].
  AutonomyOptionsState() {
    _init();
  }

  final _autonomyController = AutonomyLevelsTableController();

  final _autonomyList = <AutonomyLevel>[];

  /// All instances of [AutonomyLevel] saved on the database.
  List<AutonomyLevel> get autonomyList => _autonomyList;

  /// The form controller of this screen.
  final formState = GlobalKey<FormState>();

  final _dealershipController = TextEditingController();

  /// The value inside dealership percentage text field.
  TextEditingController get dealershipController => _dealershipController;

  final _headquartersController = TextEditingController();

  /// The value inside headquarters percentage text field.
  TextEditingController get headquartersController => _headquartersController;

  void _init() async {
    await getAutonomyList();
  }

  /// Returns all instances of [AutonomyLevel] registered on database.
  Future<void> getAutonomyList() async {
    final result = await _autonomyController.selectAll();

    _autonomyList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }

  /// Sets the values of a given [autonomyLevel] to the respective
  /// [dealershipController] and [headquartersController].
  void setControllerValues(AutonomyLevel autonomyLevel) {
    _dealershipController.text =
        (autonomyLevel.dealershipPercentage * 100).toString();
    _headquartersController.text =
        (autonomyLevel.headquartersPercentage * 100).toString();

    notifyListeners();
  }

  /// Validates if a field's value isn't null, is not negative and
  /// doesn't go beyond 100%.
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

  /// Updates the given [autonomyLevel] parameters in database.
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
