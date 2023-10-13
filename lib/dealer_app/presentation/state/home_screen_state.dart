import 'package:flutter/material.dart';

import '../../entities/dealership.dart';
import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../usecases/database_controllers/vehicles_table_controller.dart';
import '../pages/home_screen.dart';

/// State controller of [HomeScreen] managing the data displayed.
class HomeScreenState with ChangeNotifier {
  /// Constructs an instance of [HomeScreenState] with
  /// the given [loggedUser] parameter.
  HomeScreenState(this.loggedUser) {
    _init();
  }

  /// User logged in the application.
  final User loggedUser;

  /// Whether the screen data is being loaded or not.
  bool loading = true;

  final _vehicleList = <Vehicle>[];

  /// Instances of [Vehicle] to be displayed in a list view.
  List<Vehicle> get vehicleList => _vehicleList;

  final _dealershipList = <Dealership>[];

  /// Instances of [Dealership] to be displayed in dropdown.
  List<Dealership> get dealershipList => _dealershipList;

  int? _dealershipController;

  /// Controls what instance of [Dealership] is selected by the dropdown.
  int? get dealershipController => _dealershipController;

  final _vehiclesTableController = VehiclesTableController();
  final _dealershipsTableController = DealershipsTableController();

  void _init() async {
    loading = true;
    await _getVehicles();
    await _getDealerships();
    loading = false;
    notifyListeners();
  }

  Future<void> _getVehicles() async {
    loading = true;

    var dealershipId = 0;

    loggedUser.roleId == 1
        ? dealershipId = _dealershipController ?? 1
        : dealershipId = loggedUser.dealershipId;

    final result =
        await _vehiclesTableController.selectByDealership(dealershipId);

    result.removeWhere((element) => element.isSold == true);

    _vehicleList
      ..clear()
      ..addAll(result.reversed);

    loading = false;

    notifyListeners();
  }

  Future<void> _getDealerships() async {
    final result = await _dealershipsTableController.selectAll();

    _dealershipList
      ..clear()
      ..addAll(result)
      ..removeWhere((element) => element.isActive == false);

    notifyListeners();
  }

  /// Changes the selected dealership stock being shown to user.
  void setDealership(Dealership dealership) async {
    _dealershipController = dealership.id!;
    await _getVehicles();

    notifyListeners();
  }
}
