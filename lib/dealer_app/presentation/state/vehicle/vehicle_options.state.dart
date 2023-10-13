import 'dart:io';

import 'package:flutter/material.dart';

import '../../../entities/vehicle.dart';
import '../../../repository/internal_storage.dart';
import '../../../usecases/database_controllers/vehicles_table_controller.dart';
import '../../pages/vehicle/vehicle_options_screen.dart';

/// State controller of [VehicleOptionsScreen] managing the data displayed.
class VehicleOptionsState with ChangeNotifier {
  /// Constructs an instance of [VehicleOptionsState] with
  /// the given [vehicleId] parameter.
  VehicleOptionsState(int vehicleId) {
    loadData(vehicleId);
  }

  /// Whether the screen data is being loaded or not.
  bool loading = true;

  /// The instance of [Vehicle] which the information is being shown.
  late Vehicle vehicle;

  final _vehicleController = VehiclesTableController();

  /// Gets an instance of [Vehicle] from
  /// the database with the given [vehicleId].
  void loadData(int vehicleId) async {
    loading = true;
    final result = await _vehicleController.selectSingleVehicle(vehicleId);

    vehicle = result;
    loading = false;

    notifyListeners();
  }

  /// Loads an image from the local storage with a given [imageName].
  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadFileLocal(imageName);
    return result;
  }

  /// Deletes an instance of [Vehicle] from the database.
  void deleteVehicle(Vehicle vehicle) async {
    await _vehicleController.delete(vehicle);

    notifyListeners();
  }
}
