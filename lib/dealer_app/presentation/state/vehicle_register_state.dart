import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';

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

  String? _photoController;

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
  String? get photoController => _photoController;

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
          notifyListeners();
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
      photo: photoController,
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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      _photoController = image.path;

      notifyListeners();
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
    }
  }

  Future takePhoto() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      _photoController = image.path;
      notifyListeners();
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
    }
  }
}
