import 'dart:io';

import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../usecases/save_load_images.dart';

class HomeScreenState with ChangeNotifier {
  HomeScreenState(User user) {
    init(user);
  }

  void init(User user) async {
    loggedUser = user;
    getVehicles();
    loading = false;
    notifyListeners();
  }

  late User loggedUser;
  bool loading = true;

  User get user => loggedUser;

  final vehicleList = <Vehicle>[];

  Future<void> getVehicles() async {
    final result =
        await VehiclesTableController().select(loggedUser.dealershipId);

    for (final item in result) {
      vehicleList.add(item);
    }

    notifyListeners();
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }
}
