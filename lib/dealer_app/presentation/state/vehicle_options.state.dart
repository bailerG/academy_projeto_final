import 'dart:io';

import 'package:flutter/material.dart';

import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/save_load_images.dart';

class VehicleOptionsState with ChangeNotifier {
  VehicleOptionsState(int vehicleId) {
    loadData(vehicleId);
  }

  bool loading = true;

  final vehicleController = VehiclesTableController();
  late Vehicle vehicle;

  Future<void> loadData(int vehicleId) async {
    loading = true;
    final result = await vehicleController.selectSingleVehicle(vehicleId);
    if (result.length == 1) {
      vehicle = result.first;
      loading = false;
      notifyListeners();
    } else {
      throw Exception('The select method returned more than one vehicle');
    }
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void deleteVehicle(Vehicle vehicle) async {
    await vehicleController.delete(vehicle);

    notifyListeners();
  }
}
