import 'dart:io';

import 'package:flutter/material.dart';

import '../../entities/vehicle.dart';
import '../../repository/save_load_images.dart';

class VehicleOptionsState with ChangeNotifier {
  VehicleOptionsState({
    required this.vehicle,
  });

  final Vehicle vehicle;

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void editVehicle() async {}

  void deleteVehicle() async {}

  void sellVehicle() async {}
}
