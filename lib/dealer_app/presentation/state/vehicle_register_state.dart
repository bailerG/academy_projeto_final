import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/fipe_api.dart';

class VehicleRegisterState with ChangeNotifier {
  VehicleRegisterState() {
    init();
  }

  final formState = GlobalKey<FormState>();

  final _vehicleController = VehiclesTableController();

  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _builtYearController = TextEditingController();
  final _modelYearController = TextEditingController();
  final _priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  TextEditingController get modelController => _modelController;

  TextEditingController get plateController => _plateController;

  TextEditingController get brandController => _brandController;

  TextEditingController get builtYearController => _builtYearController;

  TextEditingController get modelYearController => _modelYearController;

  MoneyMaskedTextController get priceController => _priceController;

  final modelFieldFocusNode = FocusNode();

  final allBrands = <String>[];
  final allModels = <String>[];

  void init() async {
    final result = await getBrandNames();

    allBrands.addAll(result ?? []);

    modelFieldFocusNode.addListener(
      () async {
        if (modelFieldFocusNode.hasFocus) {
          final result = await getModelsByBrand(brandController.text);
          allModels.addAll(result!);
        }
      },
    );
  }

  Future<List<String>?> getBrandNames() async {
    final brandsList = await getCarBrands();

    final brandNames = <String>[];

    if (brandsList != null) {
      for (final item in brandsList) {
        brandNames.add(item.name!);
      }
    }
    return brandNames;
  }

  Future<List<String>?> getModelsByBrand(String brand) async {
    final modelsList = await getCarModel(brand);

    final modelNames = <String>[];

    if (modelsList != null) {
      for (final item in modelsList) {
        modelNames.add(item.name!);
      }
    }
    return modelNames;
  }

  Future<void> insert() async {
    final vehicle = Vehicle(
      model: modelController.text,
      plate: plateController.text,
      brand: brandController.text,
      builtYear: int.parse(builtYearController.text),
      modelYear: int.parse(modelYearController.text),
      photo: '',
      pricePaid: double.parse(priceController.text),
      purchasedWhen: DateTime.now(),
      dealershipId: 1,
    );

    await _vehicleController.insert(vehicle);

    modelController.clear();
    plateController.clear();
    brandController.clear();
    builtYearController.clear();
    modelYearController.clear();
    priceController.clear();

    notifyListeners();
  }
}
