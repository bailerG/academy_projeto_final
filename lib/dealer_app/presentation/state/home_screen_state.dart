import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';

class HomeScreenState with ChangeNotifier {
  HomeScreenState() {
    getVehicles();
  }

  late User _loggedUser;
  User get loggedUser => _loggedUser;

  void setLoggedUser(User user) {
    _loggedUser = user;
    return;
  }

  final _vehicleList = <Vehicle>[];
  List<Vehicle> get vehicleList => _vehicleList;

  Future<void> getVehicles() async {
    final result =
        await VehiclesTableController().select(_loggedUser.dealershipId);

    for (final item in result) {
      _vehicleList.add(item);
    }
    notifyListeners();
    return;
  }
}
