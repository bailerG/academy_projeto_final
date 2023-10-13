import 'package:flutter/material.dart';

import '../../../entities/autonomy_level.dart';
import '../../../entities/dealership.dart';
import '../../../usecases/database_controllers/autonomy_table_controller.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../pages/dealership/dealership_list_screen.dart';

/// State controller of [DealershipListScreen] managing the data displayed.
class DealershipListState with ChangeNotifier {
  /// Constructs an instance of [DealershipListState].
  DealershipListState() {
    init();
  }

  /// Whether the screen data is being loaded or not.
  bool loading = true;

  final _dealershipController = DealershipsTableController();
  final _autonomyController = AutonomyLevelsTableController();

  final _dealershipList = <Dealership>[];

  /// All instances of [Dealership] registered on database.
  List<Dealership> get dealershipList => _dealershipList;

  final _autonomyList = <AutonomyLevel>[];

  /// All instances of [AutonomyLevel] registered on database.
  List<AutonomyLevel> get autonomyList => _autonomyList;

  /// Loads all data displayed on [DealershipListScreen].
  void init() async {
    loading = true;

    await _getDealershipList();
    await _getAutonomyList();

    loading = false;

    notifyListeners();
  }

  Future<void> _getDealershipList() async {
    final result = await _dealershipController.selectAll();
    _dealershipList
      ..clear()
      ..addAll(result)
      ..sort(
        (a, b) => a.isActive.toString().compareTo(b.isActive.toString()),
      );

    notifyListeners();
  }

  Future<void> _getAutonomyList() async {
    final result = await _autonomyController.selectAll();
    _autonomyList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }
}
