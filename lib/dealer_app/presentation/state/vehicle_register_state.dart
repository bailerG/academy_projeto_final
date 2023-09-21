import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../entities/user.dart';
import '../../entities/vehicle.dart';
import '../../repository/database.dart';
import '../../repository/fipe_api.dart';
import '../../repository/save_load_images.dart';

class VehicleRegisterState with ChangeNotifier {
  VehicleRegisterState(User user) {
    init(user);
  }

  late User _loggedUser;

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

  void init(User user) async {
    _loggedUser = user;

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
      photos: photoController.join('|'),
      pricePaid: double.parse(
        priceController.text.replaceAll(RegExp(r','), ''),
      ),
      purchasedWhen: DateFormat('dd/MM/yyyy').parse(dateController.text),
      dealershipId: _loggedUser.dealershipId,
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
    final result = await LocalStorage().loadImageLocal(imageName);
    return result;
  }

  void setPickedDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }
}
