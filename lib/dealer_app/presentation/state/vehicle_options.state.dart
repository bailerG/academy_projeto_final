import 'dart:io';

import 'package:flutter/material.dart';

import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/save_load_images.dart';

class VehicleOptionsState with ChangeNotifier {
  VehicleOptionsState();

  final vehicleController = VehiclesTableController();

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void editVehicle() async {}

  void deleteVehicle(Vehicle vehicle) async {
    await vehicleController.delete(vehicle);

    notifyListeners();
  }

  void sellVehicle() async {}
}
