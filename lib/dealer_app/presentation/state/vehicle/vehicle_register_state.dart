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
import '../../pages/vehicle/vehicle_register_screen.dart';

/// State controller of [VehicleRegisterScreen] managing the data displayed.
class VehicleRegisterState with ChangeNotifier {
  /// Constructs an instance of [VehicleRegisterState] with
  /// the given [user] and [vehicle] parameters.
  VehicleRegisterState({
    required User user,
    this.vehicle,
  }) {
    _init(
      user,
      vehicle,
    );
  }

  late User _loggedUser;

  bool _editing = false;

  /// Whether there is an instance of [Vehicle] being edited or not.
  bool get editing => _editing;

  /// An instance of vehicle that will be edited.
  Vehicle? vehicle;

  /// The form controller of this screen.
  final formState = GlobalKey<FormState>();

  final _vehicleController = VehiclesTableController();

  final _modelController = TextEditingController();

  /// The value inside model text field.
  TextEditingController get modelController => _modelController;

  final _plateController = TextEditingController();

  /// The value inside plate text field.
  TextEditingController get plateController => _plateController;

  final _brandController = TextEditingController();

  /// The value inside brand text field.
  TextEditingController get brandController => _brandController;

  final _builtYearController = TextEditingController();

  /// The value inside year built text field.
  TextEditingController get builtYearController => _builtYearController;

  final _modelYearController = TextEditingController();

  /// The value inside model year text field.
  TextEditingController get modelYearController => _modelYearController;

  final _dateController = TextEditingController();

  /// The value inside date picker.
  TextEditingController get dateController => _dateController;

  final _photoController = <String>[];

  /// The value inside image picker.
  List<String> get photoController => _photoController;

  final _priceController = MoneyMaskedTextController(
    decimalSeparator: '.',
    thousandSeparator: ',',
  );

  /// The value inside price text field.
  MoneyMaskedTextController get priceController => _priceController;

  /// Checks if model field is being utilized or not.
  final modelFieldFocusNode = FocusNode();

  /// All brands returned from Fipe API.
  final allBrands = <String>[];

  /// All models from a given brand returned from Fipe API.
  final allModels = <String>[];

  void _init(User user, Vehicle? vehicle) async {
    _loggedUser = user;
    _editing = false;

    if (vehicle == null) {
      final result = await _getBrandNames();

      allBrands.addAll(result ?? []);

      _showModels();
    } else {
      _editCar(vehicle);
      _editing = true;
    }
  }

  void _showModels() async {
    modelFieldFocusNode.addListener(
      () async {
        if (modelFieldFocusNode.hasFocus) {
          final result = await _getModelsByBrand(brandController.text);
          allModels.clear();
          allModels.addAll(result!);
          notifyListeners();
        }
      },
    );
  }

  Future<List<String>?> _getBrandNames() async {
    final brandsList = await getCarBrands();

    final brandNames = <String>[];

    if (brandsList != null) {
      for (final item in brandsList) {
        brandNames.add(item.name!);
      }
    }
    return brandNames;
  }

  Future<List<String>?> _getModelsByBrand(String brand) async {
    final modelsList = await getCarModel(brand);

    final modelNames = <String>[];

    if (modelsList != null) {
      for (final item in modelsList) {
        modelNames.add(item.name!);
      }
    }
    return modelNames;
  }

  /// Registers a new instance of [Vehicle] in the database
  /// with the inputs given from user.
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

  /// Opens up phone's photo gallery so the user can choose images.
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

  /// Opens up phone's camera app so the user can take a photo.
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

  /// Loads a given image by its [imageName].
  Future<File> loadVehicleImage(String imageName) async {
    final result = await LocalStorage().loadFileLocal(imageName);
    return result;
  }

  /// Sets the date a vehicle was bought.
  void setPickedDate(String date) {
    _dateController.text = date;
    notifyListeners();
  }

  void _editCar(Vehicle vehicle) {
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

  /// Updates an instance of [Vehicle] saved on the database with
  /// inputs from user.
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
