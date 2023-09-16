import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/fipe_api.dart';

class HomeScreenState with ChangeNotifier {
  HomeScreenState(User user) {
    init(user);
  }

  void init(User user) async{
    loggedUser = user;
    await getCarModel('7');
    getVehicles();
    loading = false;
    notifyListeners();
  }

  late User loggedUser;
  bool loading = true;

  User get user => loggedUser;

  final _vehicleList = <Vehicle>[];
  List<Vehicle> get vehicleList => _vehicleList;

  Future<void> getVehicles() async {
    final result =
        await VehiclesTableController().select(loggedUser.dealershipId);

    for (final item in result) {
      _vehicleList.add(item);
    }

    notifyListeners();
  }
}
