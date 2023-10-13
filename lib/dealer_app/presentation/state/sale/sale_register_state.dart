import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:intl/intl.dart';

import '../../../entities/autonomy_level.dart';
import '../../../entities/sale.dart';
import '../../../entities/user.dart';
import '../../../entities/vehicle.dart';
import '../../../usecases/database_controllers/autonomy_table_controller.dart';
import '../../../usecases/database_controllers/dealerships_table_controller.dart';
import '../../../usecases/database_controllers/sale_table_controller.dart';
import '../../../usecases/database_controllers/vehicles_table_controller.dart';
import '../../pages/sale/sales_form_popup.dart';

/// State controller of [SaleForm] managing the data displayed.
class SaleRegisterState with ChangeNotifier {
  /// Constructs an instance of [SaleRegisterState] with
  /// the given [user] and [vehicle] parameters.
  SaleRegisterState(
    this.user,
    this.vehicle,
  ) {
    _init();
  }

  /// The current logged user.
  final User user;

  /// The vehicle being sold.
  final Vehicle vehicle;

  /// The [AutonomyLevel] from the dealership that is selling [vehicle].
  late AutonomyLevel autonomyLevel;

  final _salesController = SaleTableController();
  final _dealershipController = DealershipsTableController();
  final _autonomyController = AutonomyLevelsTableController();
  final _vehicleController = VehiclesTableController();

  /// The form controller of this screen.
  final formState = GlobalKey<FormState>();

  final _cpfController = TextEditingController();

  /// The value inside cpf text field.
  TextEditingController get cpfController => _cpfController;

  final _nameController = TextEditingController();

  /// The value inside name text field.
  TextEditingController get nameController => _nameController;

  final _dateController = TextEditingController();

  /// The value inside date picker.
  TextEditingController get dateController => _dateController;

  final _priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  /// The value inside price text field.
  MoneyMaskedTextController get priceController => _priceController;

  void _init() async {
    await _getAutonomyLevel(vehicle.dealershipId);
    notifyListeners();
  }

  /// Registers a new instance of [Sale]
  /// into the database with the inputs given from user.
  void registerSale() async {
    final sale = Sale(
      customerCpf: int.parse(cpfController.text),
      customerName: nameController.text,
      soldWhen: DateFormat('dd/MM/yyyy').parse(dateController.text),
      priceSold: double.parse(
        priceController.text.replaceAll(RegExp(r','), ''),
      ),
      dealershipPercentage: autonomyLevel.dealershipPercentage,
      headquartersPercentage: autonomyLevel.headquartersPercentage,
      safetyPercentage: autonomyLevel.safetyPercentage,
      vehicleId: vehicle.id!,
      dealershipId: vehicle.dealershipId,
      userId: user.id!,
      isComplete: true,
    );

    await _salesController.insert(sale);

    _setVehicleAsSold();

    cpfController.clear();
    nameController.clear();
    dateController.clear();
    priceController.updateValue(0.00);
  }

  Future<void> _getAutonomyLevel(int dealershipId) async {
    final dealership = await _dealershipController.selectById(dealershipId);

    autonomyLevel =
        await _autonomyController.selectById(dealership.autonomyLevelId);
  }

  /// Sets a new value to [_dateController].
  void setPickedDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }

  void _setVehicleAsSold() async {
    final soldVehicle = Vehicle(
      id: vehicle.id,
      model: vehicle.model,
      plate: vehicle.plate,
      brand: vehicle.brand,
      builtYear: vehicle.builtYear,
      photos: vehicle.photos,
      modelYear: vehicle.modelYear,
      pricePaid: vehicle.pricePaid,
      purchasedDate: vehicle.purchasedDate,
      dealershipId: vehicle.dealershipId,
      isSold: true,
    );

    await _vehicleController.update(soldVehicle);

    notifyListeners();
  }
}
