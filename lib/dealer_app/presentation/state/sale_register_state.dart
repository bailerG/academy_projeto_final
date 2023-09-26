import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

import '../../entities/autonomy_level.dart';
import '../../entities/sale.dart';
import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';

class SaleRegisterState with ChangeNotifier {
  SaleRegisterState(
    this.user,
    this.vehicle,
  ) {
    init();
  }

  final User user;
  final Vehicle vehicle;
  late AutonomyLevel autonomyLevel;

  final _salesController = SaleTableController();
  final _dealershipController = DealershipTableController();
  final _autonomyController = AutonomyLevelsTableController();
  final _vehicleController = VehiclesTableController();

  final formState = GlobalKey<FormState>();

  final _cpfController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  TextEditingController get cpfController => _cpfController;
  TextEditingController get nameController => _nameController;
  TextEditingController get dateController => _dateController;
  MoneyMaskedTextController get priceController => _priceController;

  void init() async {
    getAutonomyLevel(vehicle.dealershipId);
    notifyListeners();
  }

  void registerSale() async {
    final sale = Sale(
      customerCpf: int.parse(cpfController.text),
      customerName: nameController.text,
      soldWhen: DateFormat('dd/MM/yyyy').parse(dateController.text),
      priceSold: double.parse(
        priceController.text.replaceAll(RegExp(r','), ''),
      ),
      dealershipPercentage: autonomyLevel.dealershipPercentage,
      businessPercentage: autonomyLevel.headquartersPercentage,
      safetyPercentage: autonomyLevel.safetyPercentage,
      vehicleId: vehicle.id!,
      dealershipId: vehicle.dealershipId,
      userId: user.id!,
    );

    await _salesController.insert(sale);

    setVehicleAsSold();

    cpfController.clear();
    nameController.clear();
    dateController.clear();
    priceController.updateValue(0.00);
  }

  Future<void> getAutonomyLevel(int dealershipId) async {
    final dealership = await _dealershipController.selectById(dealershipId);

    autonomyLevel =
        await _autonomyController.selectById(dealership.autonomyLevelId);
  }

  void setPickedDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }

  void setVehicleAsSold() async {
    final soldVehicle = Vehicle(
      id: vehicle.id,
      model: vehicle.model,
      plate: vehicle.plate,
      brand: vehicle.brand,
      builtYear: vehicle.builtYear,
      photos: vehicle.photos,
      modelYear: vehicle.modelYear,
      pricePaid: vehicle.pricePaid,
      purchasedWhen: vehicle.purchasedWhen,
      dealershipId: vehicle.dealershipId,
      isSold: true,
    );

    await _vehicleController.update(soldVehicle);

    notifyListeners();
  }
}
