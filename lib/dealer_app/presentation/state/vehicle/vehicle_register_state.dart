import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../entities/user.dart';
import '../../../entities/vehicle.dart';
import '../../../repository/fipe_api.dart';
import '../../../repository/internal_storage.dart';
import '../../../usecases/database_controllers/vehicles_table_controller.dart';

class VehicleRegisterState with ChangeNotifier {
  VehicleRegisterState({
    required User user,
    this.vehicle,
  }) {
    init(
      user,
      vehicle,
    );
  }

  late User _loggedUser;

  bool editing = false;

  Vehicle? vehicle;

  final formState = GlobalKey<FormState>();

  final _vehicleController = VehiclesTableController();

  final _modelController = TextEditingController();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _builtYearController = TextEditingController();
  final _modelYearController = TextEditingController();
  final _dateController = TextEditingController();

  final _photoController = <String>[];

  final _priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  TextEditingController get modelController => _modelController;
  TextEditingController get plateController => _plateController;
  TextEditingController get brandController => _brandController;
  TextEditingController get builtYearController => _builtYearController;
  TextEditingController get modelYearController => _modelYearController;
  TextEditingController get dateController => _dateController;
  MoneyMaskedTextController get priceController => _priceController;

  List<String> get photoController => _photoController;

  final modelFieldFocusNode = FocusNode();

  final allBrands = <String>[];
  final allModels = <String>[];

  void init(User user, Vehicle? vehicle) async {
    _loggedUser = user;
    editing = false;

    if (vehicle == null) {
      final result = await getBrandNames();

      allBrands.addAll(result ?? []);

      showModels();
    } else {
      editCar(vehicle);
      editing = true;
    }
  }

  void showModels() async {
    modelFieldFocusNode.addListener(
      () async {
        if (modelFieldFocusNode.hasFocus) {
          final result = await getModelsByBrand(brandController.text);
          allModels.clear();
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
      photos: photoController.join('|'),
      pricePaid: double.parse(
        priceController.text.replaceAll(RegExp(r','), ''),
      ),
      purchasedDate: DateFormat('dd/MM/yyyy').parse(dateController.text),
      dealershipId: _loggedUser.dealershipId,
      isSold: false,
    );

    await _vehicleController.insert(vehicle);

    modelController.clear();
    plateController.clear();
    brandController.clear();
    builtYearController.clear();
    modelYearController.clear();
    _photoController.clear();
    priceController.updateValue(0.00);
  }

  Future<void> pickImage() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      final local = LocalStorage();

      for (final item in images) {
        final image = File(item.path);
        final imageName = DateTime.now().toString();
        await local.saveImageLocal(image, imageName);

        _photoController.add(imageName);
      }

      notifyListeners();
    } on PlatformException catch (e) {
      log(e.toString());
    }
  }

  Future<void> takePhoto() async {
    try {
      final imageXFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      final local = LocalStorage();

      final image = File(imageXFile!.path);
      final imageName = DateTime.now().toString();
      await local.saveImageLocal(image, imageName);

      _photoController.add(imageName);

      notifyListeners();
    } on PlatformException catch (e) {
      log(
        e.toString(),
      );
    }
  }

  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadFileLocal(imageName);
    return result;
  }

  void setPickedDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }

  void editCar(Vehicle vehicle) {
    brandController.text = vehicle.brand;
    modelController.text = vehicle.model;
    builtYearController.text = vehicle.builtYear.toString();
    modelYearController.text = vehicle.modelYear.toString();
    plateController.text = vehicle.plate;
    dateController.text =
        DateFormat('dd/MM/yyyy').format(vehicle.purchasedDate);
    priceController.text = vehicle.pricePaid.toStringAsFixed(2);
    photoController.addAll(vehicle.photos!.split('|'));

    notifyListeners();
  }

  Future<void> update() async {
    final editedCar = Vehicle(
      id: vehicle!.id,
      model: modelController.text,
      plate: plateController.text,
      brand: brandController.text,
      builtYear: int.parse(builtYearController.text),
      modelYear: int.parse(modelYearController.text),
      pricePaid: double.parse(
        priceController.text.replaceAll(RegExp(r','), ''),
      ),
      purchasedDate: DateFormat('dd/MM/yyyy').parse(dateController.text),
      dealershipId: vehicle!.dealershipId,
      photos: photoController.join('|'),
      isSold: false,
    );

    await _vehicleController.update(editedCar);

    modelController.clear();
    plateController.clear();
    brandController.clear();
    builtYearController.clear();
    modelYearController.clear();
    _photoController.clear();
    priceController.updateValue(0.00);
  }
}
