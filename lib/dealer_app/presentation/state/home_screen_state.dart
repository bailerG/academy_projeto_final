import 'dart:io';

import 'package:flutter/material.dart';

import '../../entities/dealership.dart';
import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/save_load_images.dart';

class HomeScreenState with ChangeNotifier {
  HomeScreenState(User user) {
    init(user);
  }

  late User loggedUser;
  bool loading = true;

  User get user => loggedUser;

  final _vehicleList = <Vehicle>[];
  List<Vehicle> get vehicleList => _vehicleList;

  final _dealershipList = <Dealership>[];
  List<Dealership> get dealershipList => _dealershipList;

  int? _dealershipController;
  int? get dealershipController => _dealershipController;

  final _vehiclesTableController = VehiclesTableController();
  final _dealershipsTableController = DealershipsTableController();

  void init(User user) async {
    loggedUser = user;
    await getVehicles();
    await getDealerships();
    loading = false;
    notifyListeners();
  }

  Future<void> getVehicles() async {
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
      ..addAll(result);

    loading = false;

    notifyListeners();
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  Future<void> getDealerships() async {
    final result = await _dealershipsTableController.selectAll();

    _dealershipList
      ..clear()
      ..addAll(result)
      ..removeWhere((element) => element.isActive == false);

    notifyListeners();
  }

  void setDealership(Dealership dealership) async {
    _dealershipController = dealership.id!;
    await getVehicles();

    notifyListeners();
  }
}
