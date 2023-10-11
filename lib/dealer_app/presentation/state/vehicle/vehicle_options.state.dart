import 'dart:io';

import 'package:flutter/material.dart';

import '../../../entities/vehicle.dart';
import '../../../repository/internal_storage.dart';
import '../../../usecases/database_controllers/vehicles_table_controller.dart';

class VehicleOptionsState with ChangeNotifier {
  VehicleOptionsState(int vehicleId) {
    loadData(vehicleId);
  }

  bool loading = true;

  final vehicleController = VehiclesTableController();
  late Vehicle vehicle;

  void loadData(int vehicleId) async {
    loading = true;
    final result = await vehicleController.selectSingleVehicle(vehicleId);

    vehicle = result;
    loading = false;

    notifyListeners();
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadFileLocal(imageName);
    return result;
  }

  void deleteVehicle(Vehicle vehicle) async {
    await vehicleController.delete(vehicle);

    notifyListeners();
  }
}
