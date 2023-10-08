import 'package:flutter/material.dart';

import '../../../entities/autonomy_level.dart';
import '../../../entities/dealership.dart';
import '../../../repository/database.dart';

class DealershipListState with ChangeNotifier {
  DealershipListState() {
    init();
  }

  bool loading = true;

  final _dealershipController = DealershipsTableController();
  final _autonomyController = AutonomyLevelsTableController();

  final _dealershipList = <Dealership>[];
  final _autonomyList = <AutonomyLevel>[];

  List<Dealership> get dealershipList => _dealershipList;
  List<AutonomyLevel> get autonomyList => _autonomyList;

  void init() async {
    await getDealershipList();
    await getAutonomyList();

    loading = false;

    notifyListeners();
  }

  Future<void> getDealershipList() async {
    final result = await _dealershipController.selectAll();
    _dealershipList
      ..clear()
      ..addAll(result)
      ..sort(
        (a, b) => a.isActive.toString().compareTo(b.isActive.toString()),
      );

    notifyListeners();
  }

  Future<void> getAutonomyList() async {
    final result = await _autonomyController.selectAll();
    _autonomyList
      ..clear()
      ..addAll(result);

    notifyListeners();
  }
}
